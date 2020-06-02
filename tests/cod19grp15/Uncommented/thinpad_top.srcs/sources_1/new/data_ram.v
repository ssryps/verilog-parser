`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/23 17:38:01
// Design Name: 
// Module Name: data_ram
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

`include "defines.v"

module data_ram(
    input wire clk,
    input wire ce,
    input wire we,
    input wire[`DataAddrBus] addr,
    input wire[3:0] sel,
    input wire[`DataBus] data_i,
    output reg[`DataBus] data_o
);

    reg[`ByteWidth] data_mem0[0:`DataMemNum-1];
    reg[`ByteWidth] data_mem1[0:`DataMemNum-1];
    reg[`ByteWidth] data_mem2[0:`DataMemNum-1];
    reg[`ByteWidth] data_mem3[0:`DataMemNum-1];
    
    // д����
    always @ (posedge clk) begin
        if (ce == `ChipDisable) begin
//            data_o <= `ZeroWord;
        end else if (we == `WriteEnable) begin
            if (sel[3] == 1'b1) data_mem3[addr[`DataMemNumLog2+1:2]] <= data_i[31:24];
            if (sel[2] == 1'b1) data_mem2[addr[`DataMemNumLog2+1:2]] <= data_i[23:16];
            if (sel[1] == 1'b1) data_mem1[addr[`DataMemNumLog2+1:2]] <= data_i[15:8];
            if (sel[0] == 1'b1) data_mem0[addr[`DataMemNumLog2+1:2]] <= data_i[7:0];
        end
    end
    
    // ������
    always @ (*) begin
        if (ce == `ChipDisable)
            data_o <= `ZeroWord;
        else if (we == `WriteDisable) begin
            data_o <= {data_mem3[addr[`DataMemNumLog2+1:2]],
                       data_mem2[addr[`DataMemNumLog2+1:2]],
                       data_mem1[addr[`DataMemNumLog2+1:2]],
                       data_mem0[addr[`DataMemNumLog2+1:2]]};
        end
        else
            data_o <= `ZeroWord;
    end
endmodule
