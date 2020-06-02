`timescale 1ns / 1ps

`include "constants.vh"
`default_nettype none

module routing_table(
    input wire clk,
    input wire rst,
    
    input wire [`IPV4_WIDTH-1:0] i_dest_ip,
    input wire i_valid,
    
    output logic [`IPV4_WIDTH-1:0] o_next_ip,
    output logic [`PORT_WIDTH-1:0] o_port,
    output logic o_ready,
    output logic o_valid,
    input wire i_ready,
    output logic o_not_found,
    
    input wire os_clk,
    input wire os_rst,
    input wire os_update,
    input wire os_insert_or_delete,
    output reg os_updateready,
    input wire [`IPV4_WIDTH-1:0] os_nxthop,
    input wire [`IPV4_WIDTH-1:0] os_ip,
    input wire [`PORT_WIDTH-1:0] os_port,
    input wire [`ROUTING_MASK_WIDTH-1:0] os_mask
);


logic [`ROUTING_TABLE_ENTRY_WIDTH-1:0] data_in_a,data_in_b,data_out_a,data_out_b;
logic [`ROUTING_BUCKET_INDEX_WIDTH-1:0] addr_a, addr_b, base_addr, mem_size;
logic we_a,we_b;
logic[10:0] state, wr_state, inner_state, last_state, b_last_state;
logic ready, updating, reading, is_insert;
logic [5:0] new_mask;
logic [`IPV4_WIDTH-1:0] new_ip, lookup_ip, new_nxt_hop, default_nxt_hop, ans_hop;
logic [`PORT_WIDTH-1:0] new_port,ans_port,default_port;
/*xpm_memory_tdpram #(
    .ADDR_WIDTH_A(`ROUTING_BUCKET_INDEX_WIDTH),
    .ADDR_WIDTH_B(`ROUTING_BUCKET_INDEX_WIDTH),
    .READ_DATA_WIDTH_B(`ROUTING_TABLE_ENTRY_WIDTH),
    .READ_DATA_WIDTH_A(`ROUTING_TABLE_ENTRY_WIDTH),
    .WRITE_DATA_WIDTH_B(`ROUTING_TABLE_ENTRY_WIDTH),
    .WRITE_DATA_WIDTH_A(`ROUTING_TABLE_ENTRY_WIDTH),
    .BYTE_WRITE_WIDTH_B(`ROUTING_TABLE_ENTRY_WIDTH),
    .BYTE_WRITE_WIDTH_A(`ROUTING_TABLE_ENTRY_WIDTH),
    .READ_LATENCY_A(1),
    .READ_LATENCY_B(1),
    .MEMORY_SIZE(`ROUTING_TABLE_ENTRY_WIDTH*`ROUTING_BUCKET_INDEX_COUNT),
    .MEMORY_INIT_FILE("tmp.mem")
)*/
blk_mem_gen_0 jgnb_xpm_memory_tdpram (
    .dina(data_in_a),
    .addra(addr_a),
    .wea(we_a),
    .douta(data_out_a),
    .clka(os_clk),
    //.rsta(os_rst),
    //.ena(1'b1),

    .dinb(0),
    .addrb(addr_b),
    .web(we_b),
    .doutb(data_out_b),
    .clkb(clk)
    //.rstb(rst)
    //.enb(1'b1)
);

task writea(logic [`ROUTING_BUCKET_INDEX_WIDTH-1:0] addr,logic sign,logic[`IPV4_WIDTH-1:0] ip,logic[`PORT_WIDTH-1:0] port,logic[`ROUTING_MASK_WIDTH-1:0] len,logic[`ROUTING_BUCKET_INDEX_WIDTH-1:0] nxt_addr);
    we_a<=1;
    addr_a<=addr;
    data_in_a<={2'b0,nxt_addr,len,port,ip,sign};
endtask

task reada(logic[`ROUTING_BUCKET_INDEX_WIDTH-1:0] addr);
    we_a<=0;
    addr_a<=addr;
endtask

always @(posedge os_clk) begin
    os_updateready<=0;
    if(rst==1) begin
        mem_size<=16;
        wr_state<=0;
        b_last_state<=0;
        inner_state<=0;
        we_a<=0;
    end else begin
        we_a<=0;
        case(wr_state)
            5'b0:begin
                if(os_update) begin
                    if(int'(os_mask)==0) begin
                        default_nxt_hop<=os_nxthop;
                        default_port<=os_port;
                    end else begin
                        new_ip<=os_ip;
                        new_port<=os_port;
                        new_mask<=os_mask + 1;
                        is_insert<=os_insert_or_delete ;
                        new_nxt_hop<=os_nxthop;
                        base_addr<=0;
                        inner_state<=0;
                        wr_state<=1;
                        os_updateready<=0;
                    end
                end else begin
                    os_updateready<=1;
                end
            end
            12: begin
                we_a<=1;
                wr_state<=b_last_state;
            end
            11: begin
                if(is_insert&&int'(data_out_a[`ROUTING_MASK_START:`ROUTING_MASK_END])<new_mask-1) begin
                    writea(base_addr+(int'(new_ip[31-(b_last_state-1)*4-:4]))+inner_state-1,
                        data_out_a[0],
                        new_nxt_hop,
                        new_port,
                        new_mask-1, 
                        data_out_a[`ROUTING_SON_START:`ROUTING_SON_END]);
                end else if(!is_insert&&int'(data_out_a[`ROUTING_MASK_START:`ROUTING_MASK_END])==new_mask-1) begin
                    writea(base_addr+(int'(new_ip[31-(b_last_state-1)*4-:4]))+inner_state-1,
                        data_out_a[0],
                        32'b0,
                        2'b0,
                        5'b0, 
                        data_out_a[`ROUTING_SON_START:`ROUTING_SON_END]);
                end
                wr_state<=12;
            end
            10:begin
                wr_state<=11;
            end
            9:begin
                wr_state<=10;
            end
            // trie insert
            1,2,3,4,5,6,7,8: begin 
                if(int'(new_mask)<=wr_state*4) begin
                    if(inner_state<(1<<(wr_state*4-new_mask))) begin
                        inner_state<=inner_state+1;
                        reada(base_addr+(int'(new_ip[35-wr_state*4-:4]))+inner_state);
                        b_last_state<=wr_state;
                        wr_state<=9;
                    end else begin
                        os_updateready<=1;
                        wr_state<=0;
                        inner_state<=0;
                    end       
                end else begin
                    inner_state<=inner_state+1;
                    if(inner_state==0) begin
                        reada(base_addr+(int'(new_ip[35-wr_state*4-:4])));
                    end else if(inner_state==3) begin
                        if(data_out_a[0]==0) begin
                            inner_state<=inner_state+1;
                            writea(base_addr+(int'(new_ip[35-wr_state*4-:4])),
                                1,
                                data_out_a[`ROUTING_IPV4_START:`ROUTING_IPV4_END],
                                data_out_a[`ROUTING_PORT_START:`ROUTING_PORT_END],
                                data_out_a[`ROUTING_MASK_START:`ROUTING_MASK_END],
                                mem_size
                            );
                            mem_size<=mem_size+16;
                            base_addr<=mem_size;
                            b_last_state<=wr_state+1;
                            wr_state<=12;
                            inner_state<=0;
                        end else begin
                            base_addr<=data_out_a[`ROUTING_SON_START:`ROUTING_SON_END];
                            wr_state<=wr_state+1;
                            inner_state<=0;
                        end
                    end
                end 
            end
        endcase 
    end   
end

/*always @(*) begin
    if(rst) begin
        addr_b<=0;
    end else if(state==0) begin
        addr_b<=i_dest_ip[31:28];
    end else if(state<8) begin
        addr_b<=data_out_b[`ROUTING_SON_START:`ROUTING_SON_END]+lookup_ip[31-state*4-:4];
    end
end*/

always @(posedge clk) begin
    if(rst==1) begin
        state<=0;
        o_not_found<=0;
        o_ready<=0;
        o_valid<=0;
        we_b<=0;
    end else begin
        we_b<=0;
        o_ready<=0;
        o_valid<=0;
        case(state)
            0:begin
                if(o_valid && !i_ready) begin
                    o_valid<=1;
                    reading<=0;
                end else begin
                    if(i_valid) begin
                        lookup_ip<=i_dest_ip;
                        ans_hop<=default_nxt_hop;
                        ans_port<=default_port;
                        reading<=1;
                        o_ready<=1;
                        addr_b<=i_dest_ip[31:28];
                        last_state<=1;
                        state<=9;
                    end else begin
                        reading<=0;
                    end
                end
            end
            10: begin
                state<=last_state;
            end
            9: begin
                state<=10;
            end
            1,2,3,4,5,6,7,8: begin
                if(data_out_b[`ROUTING_MASK_START:`ROUTING_MASK_END]>0) begin
                    ans_hop<=data_out_b[`ROUTING_IPV4_START:`ROUTING_IPV4_END];
                    ans_port<=data_out_b[`ROUTING_PORT_START:`ROUTING_PORT_END];
                end
                if(data_out_b[0]==1) begin
                    addr_b<=data_out_b[`ROUTING_SON_START:`ROUTING_SON_END]+lookup_ip[31-state*4-:4];
                    state<=9;
                    last_state<=state+1;
                end else begin
                    state<=11;
                end
            end
            11:begin
                state<=0;
                reading<=0;
                if(int'(ans_hop)==0) begin
                    o_not_found<=1;
                end else begin
                    o_valid<=1;
                    o_next_ip<=ans_hop;
                    o_port<=ans_port;
                end 
            end
            default:begin
            end
        endcase
    end
end                   
endmodule