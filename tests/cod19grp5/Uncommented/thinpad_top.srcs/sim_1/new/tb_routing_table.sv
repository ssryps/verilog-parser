`timescale 1ns / 1ps

module tb_routing_table;

    logic clk;
    logic rst;

    logic [31:0] i_dest_ip;
    logic i_valid;

    logic [31:0] o_next_ip;
    logic o_ready;
    logic o_valid;
    logic o_not_found;
    
    logic read,update;
    logic updateready;
    logic [31:0] nxthop;
    logic [31:0] ip;
    logic [1:0] port;
    logic [4:0] mask;
    initial begin
        clk = 0;
        rst = 1;
        i_dest_ip = 0;
        i_valid = 0;

        repeat (10) @ (posedge clk);
        rst<=0;
        repeat (20) @ (posedge clk);
        read<=0;
        update<=1;
        nxthop<=32'hF0000000;
        ip<=32'hC0A80200;
        port<=2'b10;
        mask<=24;
        repeat (5) @ (posedge clk);
        update<=0;
        repeat (100) @ (posedge clk);
        //while(!updateready);
        read<=0;
        update<=1;
        nxthop<=32'hFF000000;
        ip<=32'hC0A80100;
        port<=2'b11;
        mask<=24;
        repeat (5) @ (posedge clk);
        update<=0;
        repeat (100) @ (posedge clk);
        //while(!updateready);
        
        i_valid<=1;
        i_dest_ip <= 32'hC0A80225;//192.168.2.37
        repeat (10) @ (posedge clk);
        //while(!o_ready);
        i_valid<=0;
        repeat (100) @ (posedge clk);
        //while(!o_valid);
        i_valid<=1;
        i_dest_ip <= 32'hC0A80125;//192.168.1.37
        repeat (10) @ (posedge clk);
        //while(!o_ready);
        i_valid<=0;
        repeat (100) @ (posedge clk);
        i_valid<=1;
        i_dest_ip <= 32'h80000002;//128.0.0.2
        repeat (10) @ (posedge clk);
        i_valid<=0;
        repeat (100) @ (posedge clk);
    end
    
    always clk = #10 ~clk; // 50MHz

    routing_table routing_table_inst(
        .clk(clk),
        .rst(rst),
        .i_dest_ip(i_dest_ip),
        .i_valid(i_valid),

        .o_next_ip(o_next_ip),
        .o_ready(o_ready),
        .o_valid(o_valid),
        .o_not_found(o_not_found),
        
        .os_clk(clk),
        .os_rst(rst),
        .os_update(update),
        .os_updateready(updateready),
        .os_nxthop(nxthop),
        .os_ip(ip),
        .os_port(port),
        .os_mask(mask)
    );

endmodule
