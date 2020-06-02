`timescale 1ns / 1ps
`include "constants.vh"
module tb_arp_table;

    logic clk;
    logic rst;
    
    logic [`IPV4_WIDTH-1:0] i_ip;          // search (mac, ip) by ip
    logic i_valid;
    
    logic [`MAC_WIDTH-1:0] o_mac;
    logic o_valid;
    logic o_not_found;
    
    logic [`IPV4_WIDTH-1:0] i_insert_ip;    // insert (mac, ip) to memory
    logic [`MAC_WIDTH-1:0] i_insert_mac;
    logic i_insert_valid;

    logic ready;

    initial begin
        clk = 0;
        rst = 1;
        i_ip = 0;
        i_valid = 0;
        i_insert_ip = 0;
        i_insert_mac = 0;
        i_insert_valid = 0;

        #100
        rst = 0;
        
        repeat (2) @ (posedge clk);
        i_insert_ip <= 32'hC0A8000A;
        i_insert_mac <= 48'h121212121212;
        i_insert_valid <= 1;
        repeat (1) @ (posedge clk);
        i_insert_valid <= 0;
        repeat (2) @ (posedge clk);
        
        repeat (2) @ (posedge clk);
        i_insert_ip <= 32'hC0A8010B;
        i_insert_mac <= 48'h343434343434;
        i_insert_valid <= 1;
        repeat (1) @ (posedge clk);
        i_insert_valid <= 0;
        repeat (2) @ (posedge clk);
        
        i_insert_ip <= 0;
        i_insert_mac <= 0;
        i_insert_valid <= 0;

        repeat (2) @ (posedge clk);
        i_ip <= 32'hC0A8000A; // 192.168.0.10
        i_valid <= 1;
        repeat (1) @ (posedge clk);
        i_valid <= 0;
        repeat (2) @ (posedge clk);

        repeat (2) @ (posedge clk);
        i_ip <= 32'hC0A8010B; // 192.168.1.11
        i_valid <= 1;
        repeat (1) @ (posedge clk);
        i_valid <= 0;
        repeat (2) @ (posedge clk);

        repeat (2) @ (posedge clk);
        i_ip <= 32'hC0A8020C; // 192.168.2.12
        i_valid <= 1;
        repeat (1) @ (posedge clk);
        i_valid <= 0;
        repeat (2) @ (posedge clk);

        repeat (2) @ (posedge clk);
        i_ip <= 32'hC0A8030D; // 192.168.3.13
        i_valid <= 1;
        repeat (1) @ (posedge clk);
        i_valid <= 0;
        repeat (2) @ (posedge clk);
    end
    
    always clk = #10 ~clk; // 50MHz

    arp_table #(
        .BUCKET_INDEX_WIDTH(3)
    ) arp_table_inst (
        .clk(clk),
        .rst(rst),

        .i_ip(i_ip),
        .i_valid(i_valid),

        .o_mac(o_mac),
        .o_valid(o_valid),
        .o_not_found(o_not_found),
        
        .i_insert_ip(i_insert_ip),
        .i_insert_mac(i_insert_mac),
        .i_insert_valid(i_insert_valid),
        
        .ready(ready)
    );

endmodule
