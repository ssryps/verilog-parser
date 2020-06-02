`timescale 1ns / 1ps

`include "constants.vh"

module eth_handler(
    input wire clk,
    input wire rst,
    
    input wire eth_rx_mac_aclk,
    input wire [7:0] eth_rx_axis_mac_tdata,
    input wire eth_rx_axis_mac_tvalid,
    input wire eth_rx_axis_mac_tlast,
    input wire eth_rx_axis_mac_tuser,
    
    input  wire eth_tx_mac_aclk,
    output logic [7:0] eth_tx_axis_mac_tdata,
    output logic eth_tx_axis_mac_tvalid,
    output logic eth_tx_axis_mac_tlast,
    output logic eth_tx_axis_mac_tuser,
    input wire eth_tx_axis_mac_tready,
    
    output reg [`IPV4_WIDTH-1:0] lookup_ip,
    input wire [`IPV4_WIDTH-1:0] nxthop_ip,
    input wire [`PORT_WIDTH-1:0] nxthop_port,
    input wire routing_table_i_ready,
    input wire routing_table_i_valid,
    output logic routing_table_o_valid,
    output logic routing_table_o_ready,

    output reg packet_w_en, // packet write enable
    output reg [`RRAM_ADDR_WIDTH-1:0] packet_w_addr,
    output reg [7:0] packet_w_data,

    output reg packet_r_en, // packet read enable
    output reg [`RRAM_ADDR_WIDTH-1:0] packet_r_addr,
    input wire [7:0] packet_r_data,

    output reg to_cpu_packet_end,      // 1: the packet has been transferred to cpu
    input wire to_cpu_packet_status,   // 1: the packet to cpu is ready

    output reg from_cpu_packet_end,    // 1: the packet has been sent
    input wire from_cpu_packet_status  // 1: the packet from cpu is ready
);

logic [7:0] fifo1_write_data,fifo3_write_data;
logic [11:0] fifo2_write_data,fifo4_write_data;
logic [7:0] fifo1_read_data,fifo3_read_data;
logic [11:0] fifo2_read_data,fifo4_read_data;
logic fifo1_wr_en,fifo2_wr_en,fifo3_wr_en,fifo4_wr_en;
logic fifo1_rd_en,fifo2_rd_en,fifo3_rd_en,fifo4_rd_en;
logic fifo1_prog_full,fifo1_full,fifo1_empty,fifo2_full,fifo2_empty,fifo3_full,fifo3_empty,fifo4_full,fifo4_empty;

//
logic [371:0] buffer;
logic [47:0] nxt_mac;
integer state, next_read_state, next_drop_state, buffer_len, inner_state, receive_cnt;
logic [7:0] drop_data;

logic [`IPV4_WIDTH-1:0] nxthop;
logic [`PORT_WIDTH-1:0] nxtport;
logic [15:0] nxtport_vlan;

integer rest_cnt, send_cnt, send_len, send_state, send_inner_state;
reg [31:0] packet_length;

// read data and len
jgnb_axis_fifo fifo1(
    .din(fifo1_write_data),
    .wr_clk(eth_rx_mac_aclk),
    .wr_en(fifo1_wr_en),
    .full(fifo1_full),
    
    .dout(fifo1_read_data),
    .rd_clk(clk),
    .empty(fifo1_empty),
    .rd_en(fifo1_rd_en),
    .rst(rst),
    
    .prog_full(fifo1_prog_full)
);
jgnb_axis_fifo24 fifo2(
    .din(fifo2_write_data),
    .wr_clk(eth_rx_mac_aclk),
    .wr_en(fifo2_wr_en),
    .full(fifo2_full),
    
    .dout(fifo2_read_data),
    .rd_clk(clk),
    .empty(fifo2_empty),
    .rd_en(fifo2_rd_en),
    .rst(rst)
);

// write data and len
jgnb_axis_fifo fifo3(
    .din(fifo3_write_data),
    .wr_clk(clk),
    .wr_en(fifo3_wr_en),
    .full(fifo3_full),
    
    .dout(fifo3_read_data),
    .rd_clk(eth_tx_mac_aclk),
    .empty(fifo3_empty),
    .rd_en(fifo3_rd_en),
    .rst(rst)
);
jgnb_axis_fifo24 fifo4(
    .din(fifo4_write_data),
    .wr_clk(clk),
    .wr_en(fifo4_wr_en),
    .full(fifo4_full),
    
    .dout(fifo4_read_data),
    .rd_clk(eth_tx_mac_aclk),
    .empty(fifo4_empty),
    .rd_en(fifo4_rd_en),
    .rst(rst)
);

logic [`PORT_WIDTH-1:0] port_id;
logic [(2**`PORT_WIDTH)-1:0][`IPV4_WIDTH-1:0] port_ip = {
    `IPV4_WIDTH'h00000390, // 144.3.0.0
    `IPV4_WIDTH'h00000290, // 144.2.0.0
    `IPV4_WIDTH'h01000080, // 128.0.0.1
    `IPV4_WIDTH'h01000040  // 64.0.0.1
};
logic [(2**`PORT_WIDTH)-1:0][`MAC_WIDTH-1:0] port_mac = {
    `MAC_WIDTH'h444444444444,
    `MAC_WIDTH'h333333333333,
    `MAC_WIDTH'h222222222222,
    `MAC_WIDTH'h111111111111
};
logic [`IPV4_WIDTH-1:0] arp_i_ip = 0;
logic arp_i_valid = 0;

logic [`MAC_WIDTH-1:0] arp_o_mac;
logic arp_ready;
logic arp_o_valid;
logic arp_o_not_found;

logic [`IPV4_WIDTH-1:0] arp_i_insert_ip = 0;
logic [`MAC_WIDTH-1:0] arp_i_insert_mac = 0;
logic arp_i_insert_valid = 0;

arp_table #(
    .BUCKET_INDEX_WIDTH(3)
) arp_table_inst (
    .clk(clk),
    .rst(rst),
    .i_ip(arp_i_ip),
    .i_valid(arp_i_valid),
    .o_mac(arp_o_mac),
    .o_valid(arp_o_valid),
    .o_not_found(arp_o_not_found),
    .i_insert_ip(arp_i_insert_ip),
    .i_insert_mac(arp_i_insert_mac),
    .i_insert_valid(arp_i_insert_valid),
    .ready(arp_ready)
);

logic fifo1_last_last = 0;
logic fifo1_packet_loss = 1;

always_ff @(posedge eth_rx_mac_aclk)
begin
    fifo1_wr_en <= 0;
    fifo2_wr_en <= 0;
    if (rst) begin
        receive_cnt <= 0;
        fifo1_write_data <= 0;
        fifo1_packet_loss <= 0;
        fifo1_last_last <= 0; // drop the first datagram after power up
        fifo1_packet_loss <= 1;
    end else if (eth_rx_axis_mac_tvalid) begin
        receive_cnt <= receive_cnt + 1;
        fifo1_write_data <= eth_rx_axis_mac_tdata;
        fifo1_wr_en <= 1;
        fifo1_last_last <= 0;
        if (eth_rx_axis_mac_tlast) begin
            fifo2_write_data <= receive_cnt + 1;
            fifo2_wr_en <= 1;
            receive_cnt <= 0;
            fifo1_last_last <= 1;
            //if(fifo1_almost_full)
                //fifo1_full<=1;
        end 
        if (fifo1_last_last) begin
            if (fifo1_prog_full) begin
                fifo1_packet_loss <= 1;
                fifo1_wr_en <= 0;
                fifo2_wr_en <= 0;
            end else begin
                fifo1_packet_loss <= 0;
            end
        end else begin
            if (fifo1_packet_loss) begin
                fifo1_wr_en <= 0;
                fifo2_wr_en <= 0;
            end
        end
    end else begin
        //if(!fifo1_almost_full)
            //fifo1_full<=0;
        fifo1_wr_en <= 0;
        fifo2_wr_en <= 0;
    end  
end

integer routing_find_cnt;
logic [20:0] check_sum_tmp;
integer nxt_state;
always @(posedge clk)
begin
    fifo1_rd_en <= 0;
    fifo2_rd_en <= 0;
    fifo3_wr_en <= 0;
    fifo4_wr_en <= 0;
    arp_i_insert_valid <= 0;
    packet_r_en <= 0;
    packet_w_en <= 0;
    from_cpu_packet_end <= 0;
    to_cpu_packet_end <= 0;
    if (rst) begin
        state <= 32'h0;
        inner_state <= 0;
        buffer <= 0;
        arp_i_ip <= 0;
        arp_i_valid <= 0;
        arp_i_insert_ip <= 0;
        arp_i_insert_mac <= 0;
        routing_table_o_ready <= 0;
        routing_table_o_valid <= 0;
        packet_r_addr <= 0;
        packet_w_addr <= 0;
        packet_w_data <= 0;
    end else begin
    case (state)
    32'h0:begin
        //if rip packet from cpu not empty,first handle that
        if (from_cpu_packet_status) begin
            inner_state <= 0;
            packet_r_en <= 1;
            packet_length <= 0;
            packet_r_addr <= `FROM_CPU_PACKET_LENGTH;
            nxt_state<=6;
            state <= 32'h3737;
        end else if (!fifo2_empty) begin
            fifo2_rd_en <= 1;
            state <= 32'h1;
        end
    end
    32'h3737:begin
        packet_r_en <= 1;
        state <= nxt_state;
    end
    32'h1:begin
        send_len <= fifo2_read_data;
        fifo2_rd_en <= 0;
        inner_state <= 0;
        buffer_len <= 18;
        next_read_state <= 32'h111;
        fifo1_rd_en <= 1;
        state <= 32'h11;
    end
    32'h11:begin
        buffer[inner_state*8+7-:8] <= fifo1_read_data;
        inner_state <= inner_state + 1;
        fifo1_rd_en <= 1;
        if (inner_state + 1 == buffer_len) begin
            fifo1_rd_en <= 0;
            state <= next_read_state;
        end
    end
    32'h111:begin
        port_id <= {buffer[119:112], buffer[127:120]} - 1;
        fifo1_rd_en <= 1;
        state <= 32'h11;
        if (buffer[111:96] != 16'h0081) begin
            fifo1_rd_en <= 0;
            state <= 32'h999;
        end else if (buffer[143:128] == 16'h0008) begin // ip package
            buffer_len <= 38;
            next_read_state <= 32'h20;
        end else if (buffer[143:128] == 16'h0608) begin // arp package
            buffer_len <= 46;
            next_read_state <= 32'h30;
        //end else if rip packet, send to router_top
        end else begin
            fifo1_rd_en <= 0;
            state <= 32'h999;
        end
    end
    32'h20:begin
        if (buffer[303:272] == 32'h090000e0) begin
            packet_length <= send_len;
            inner_state <= 0;
            state <= 32'h7;
        end else if (buffer[47:0] != port_mac[port_id]) begin
            next_drop_state <= 32'h0;
            state <= 32'h999;
        end else if (buffer[215:208] == 0) begin 
            next_drop_state <= 32'h0;
            state <= 32'h999; // If we wait too long, we will consider Routing Model died.
        end else begin
            lookup_ip <= {buffer[279:272], buffer[287:280], buffer[295:288], buffer[303:296]};
            routing_table_o_valid <= 1;
            if (routing_table_i_ready) begin
                routing_table_o_valid <= 0;
                state <= 32'h21;
                routing_find_cnt <= 0;
            end
        end
    end
    32'h21:begin //wait for valid nxthop 
        routing_find_cnt <= routing_find_cnt +1;
        if (routing_table_i_valid) begin // TODO not_found @wyz
            // buffer[215:208] is TTL
                buffer[215:208] <= buffer[215:208] - 1; // TTL -= 1
                routing_table_o_ready <= 1;
                nxthop <= {nxthop_ip[7:0], nxthop_ip[15:8], nxthop_ip[23:16], nxthop_ip[31:24]};
                nxtport <= nxthop_port;
                nxtport_vlan <= 16'h1 + nxthop_port;
                state <= 32'h215;
        end /*else if (routing_find_cnt > 50) begin // 50 is a magic number xjb set by Yazid
            next_drop_state <= 32'h0;
            state <= 32'h999; // If we wait too long, we will consider Routing Model died.
        end*/
    end
    32'h215:begin
        routing_table_o_ready <= 1;
        if(~routing_table_i_valid) begin
            state <= 32'h22;
        end
    end
    32'h22:begin
        routing_table_o_ready <= 0;
        arp_i_ip <= nxthop;
        arp_i_valid <= 1;
        if (arp_ready) begin
            nxtport_vlan <= {nxtport_vlan[7:0], nxtport_vlan[15:8]};
            check_sum_tmp <= buffer[159:144] + buffer[175:160] + buffer[191:176] + buffer[207:192] + buffer[223:208] + buffer[255:240]+buffer[271:256] + buffer[287:272] + buffer[303:288];
            state <= 32'h23;
        end
    end
    32'h23:begin
        arp_i_valid <= 0;
        if (arp_o_valid) begin
            buffer[47:0] <= arp_o_mac;
            buffer[95:48] <= buffer[47:0];
            buffer[127:112] <= nxtport_vlan;
            buffer[239:224] <= ~((check_sum_tmp >> 16) + check_sum_tmp); // checksum
            inner_state <= 0;
            state <= 32'h888;
        end
        if (arp_o_not_found) begin
            buffer_len <= 46;
            buffer <= {nxthop, 48'h0, port_ip[nxtport], port_mac[nxtport], 16'h0100, 8'h04, 8'h06, 16'h0008, 16'h0100, 16'h0608, nxtport_vlan, 16'h0081, port_mac[nxtport], 48'hffffffffffff};
            next_drop_state <= 32'h888;
            state <= 32'h999;
        end
    end
    32'h30:begin
        arp_i_insert_ip <= buffer[287:256];
        arp_i_insert_mac <= buffer[255:208];
        arp_i_insert_valid <= 1;
        if (buffer[207:200] == 8'h01) begin
            if (port_ip[port_id] == buffer[367:336]) begin
                buffer_len <= 46;
                buffer <= {buffer[287:256], buffer[255:208], port_ip[port_id], port_mac[port_id], 16'h0200, 8'h04, 8'h06, 16'h0008, 16'h0100, buffer[143:96], port_mac[port_id], buffer[95:48]};
                next_drop_state <= 32'h888;
                state <= 32'h999;
            end else begin
                next_drop_state <= 32'h0;
                state <= 32'h999;
            end
        end else begin
            next_drop_state <= 32'h0;
            state <= 32'h999;
        end
    end
    32'h6:begin
        packet_r_en <= 1;
        packet_length[inner_state*8+7-:8] <= packet_r_data;
        inner_state <= inner_state + 1;
        packet_r_addr <= packet_r_addr + 1;
        nxt_state<=32'h6;
        state<=32'h3737;
        if (inner_state + 1 == 4) begin
            packet_r_en <= 0;
            state <= 32'h66;
        end
    end
    32'h66:begin
        if (packet_length != 0) begin
            send_len <= packet_length;
            inner_state <= 0;
            packet_r_en <= 1;
            packet_r_addr <= `FROM_CPU_PACKET;
            nxt_state<=32'h666;
            state<=32'h3737;
            //state <= 32'h666;
        end else begin
            from_cpu_packet_end <= 1;
            state <= 32'h0;
        end
    end
    32'h666:begin
        packet_r_en <= 1;
        inner_state <= inner_state + 1;
        packet_r_addr <= packet_r_addr + 1;
        fifo3_wr_en <= 1;
        nxt_state<=32'h666;
        state<=32'h3737;
        if (inner_state < send_len) begin
            fifo3_write_data <= packet_r_data;
        end
        if (inner_state + 1 >= send_len) begin
            from_cpu_packet_end <= 1;
            packet_r_en <= 0;
            state <= 32'h8888;
        end
    end
    32'h7:begin
        if (inner_state == 4) begin
            inner_state <= 0;
            state <= 32'h77;
        end else begin
            packet_w_en <= 1;
            packet_w_addr <= `TO_CPU_PACKET_LENGTH + inner_state;
            packet_w_data <= packet_length[inner_state*8+7-:8];
            inner_state <= inner_state + 1;
        end
    end
    32'h77:begin
        packet_w_en <= 1;
        packet_w_addr <= `TO_CPU_PACKET + inner_state;
        if (inner_state < buffer_len) begin
            packet_w_data <= buffer[inner_state*8+7-:8];
        end else if (inner_state < send_len) begin
            packet_w_data <= fifo1_read_data;
        end
        if (inner_state + 1 >= buffer_len) begin
            fifo1_rd_en <= 1;
        end
        if (inner_state + 1 >= send_len) begin
            fifo1_rd_en <= 0;
            to_cpu_packet_end <= 1;
            state <= 32'h0;
        end
        inner_state <= inner_state + 1;
    end
    32'h888:begin // send package
        fifo3_wr_en <= 1;
        if (inner_state < buffer_len) begin
            fifo3_write_data <= buffer[inner_state*8+7-:8];
        end else if (inner_state < send_len) begin
            fifo3_write_data <= fifo1_read_data;
        end
        if (inner_state + 1 >= buffer_len) begin
            fifo1_rd_en <= 1;
        end
        if (inner_state + 1 >= send_len) begin
            fifo1_rd_en <= 0;
            state <= 32'h8888;
        end
        inner_state <= inner_state + 1;
    end
    32'h8888:begin
        fifo3_wr_en <= 0;
        fifo4_wr_en <= 1;
        fifo4_write_data <= send_len;
        state <= 32'h0;
    end
    32'h999:begin // drop fifo1
        if (inner_state < send_len) begin
            fifo1_rd_en <= 1;
            state <= 32'h9999;
        end else begin
            inner_state <= 0;
            send_len <= buffer_len;
            state <= next_drop_state;
        end
    end
    32'h9999:begin
        drop_data <= fifo1_read_data;
        inner_state <= inner_state + 1;
        fifo1_rd_en <= 1;
        if (inner_state + 1 == send_len) begin
            fifo1_rd_en <= 0;
            inner_state <= 0;
            send_len <= buffer_len;
            state <= next_drop_state;
        end
    end
    default:begin
    end
    endcase
    end
end

logic read_wait;
logic [7:0] cache_tx_tdata;
always_ff @(posedge eth_tx_mac_aclk) begin
    fifo3_rd_en<=0;
    fifo4_rd_en<=0;
    if(rst) begin
        send_state<=0;
        eth_tx_axis_mac_tlast<=0;
        eth_tx_axis_mac_tuser<=0;
        eth_tx_axis_mac_tvalid<=0;
    end else begin
        case(send_state)
        0:begin
            if(!fifo4_empty&&!eth_tx_axis_mac_tvalid) begin
                fifo4_rd_en<=1;
                fifo3_rd_en<=1;
                send_state<=1;
                cache_tx_tdata<=fifo3_read_data;
                send_cnt<=fifo4_read_data;
                send_inner_state<=0;
            end
        end
        1:begin
            eth_tx_axis_mac_tvalid<=1;
            eth_tx_axis_mac_tdata<=fifo3_read_data;
            cache_tx_tdata<=fifo3_read_data;
            fifo4_rd_en<=0;
            fifo3_rd_en<=1;
            read_wait<=0;
            send_state<=2;
        end
        2:begin 
            fifo4_rd_en<=0;
            fifo3_rd_en<=0;
            if(send_inner_state<send_cnt-1) begin
                if(eth_tx_axis_mac_tready) begin
                    if (read_wait) begin
                        read_wait<=0;
                        eth_tx_axis_mac_tdata<=cache_tx_tdata;
                    end else begin
                        eth_tx_axis_mac_tdata<=fifo3_read_data;
                    end
                    cache_tx_tdata<=fifo3_read_data;
                    if (send_inner_state<send_cnt-2) begin
                        fifo3_rd_en<=1;
                    end
                    if(send_inner_state==send_cnt-2) begin
                        eth_tx_axis_mac_tlast<=1;
                    end
                    send_inner_state<=send_inner_state+1;
                end else if (read_wait==0) begin
                    cache_tx_tdata<=fifo3_read_data;
                    read_wait<=1;
                end
            end else begin
                eth_tx_axis_mac_tlast<=0;
                eth_tx_axis_mac_tvalid<=0;
                send_state<=0;
                send_inner_state<=0;
            end
        end
        default:begin
        end
        endcase
    end
end

endmodule
