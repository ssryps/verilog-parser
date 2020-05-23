`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/03 10:02:45
// Design Name: 
// Module Name: vga_ctrl
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module vga_ctrl(
    Bus_if.slave data_bus,
    VGA_if.master vga
    );
    
wire[2:0] red,green;
wire[1:0] blue;
wire[7:0] video_pixel;
wire clk,rst;

assign clk = data_bus.clk.base;
assign rst = data_bus.clk.rst;

assign vga.video_red = video_pixel[2:0];
assign vga.video_green = video_pixel[5:3];
assign vga.video_blue = video_pixel[7:6];
// assign video_pixel = {red,green,blue};
assign vga.video_clk = clk;
wire[18:0] gaddr_r;
reg[18:0] gaddr_w;
reg[7:0] gdata_w;
wire gram_ce;
reg gram_we;
assign gram_ce = 1'b1;    

blk_mem_vga gram0(
    .addra(gaddr_w),
    .clka(clk), 
    .dina(gdata_w),
    .ena(gram_ce), 
    .wea(gram_we), 
    .addrb(gaddr_r), 
    .clkb(clk), 
    .doutb(video_pixel), 
    .enb(gram_ce) 
);

vga #(12, 800, 856, 976, 1040, 600, 637, 643, 666, 1, 1) vga800x600at75 (
    .clk(clk), 
    .hdata(red),
    .vdata({blue,green}),
    .hsync(vga.video_hsync),
    .vsync(vga.video_vsync),
    .data_enable(vga.video_de),
    .addr(gaddr_r)
);

always@(*) begin
    if(rst) begin
        gaddr_w <= 19'b0;
        gdata_w <= 8'b0;
        gram_we <= 1'b0;
    end else if(data_bus.write) begin
        gaddr_w <= data_bus.address[18:0];
        gdata_w <= data_bus.data_w[7:0];
        gram_we <= 1'b1;
    end
end
    
endmodule
