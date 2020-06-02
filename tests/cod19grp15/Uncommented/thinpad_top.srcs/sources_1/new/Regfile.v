`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.11.2019 01:45:20
// Design Name: 
// Module Name: Regfile
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


`ifdef regfile.v
`else
`define regfile.v
 
`include "defines.v"

module regfile(
       input wire 		clk,
       input wire 		rst,

       //?ºÝ¤f
       input wire 		        we,
       input wire [`RegAddrBus] waddr,
       input wire [`RegBus] 	   wdata,

       //?ºÝ¤f1
       input wire 		        re1,
       input wire [`RegAddrBus]   raddr1,
       output reg [`RegBus] 	   rdata1,

       //?ºÝ¤f2
       input wire 		        re2,
       input wire [`RegAddrBus]     raddr2,
       output reg [`RegBus] 	   rdata2

       );
   reg [`RegBus] 			regs[0:`RegNum-1];

    always @ (posedge clk) begin
        if (rst == `RstDisable) begin
            if ((we == `WriteEnable) && (waddr != 5'h0)) begin
               regs[waddr] <= wdata;
            end
        end
     end

    always @ (*) begin
        if (rst == `RstEnable) begin
          rdata1 <= `ZeroWord;
        end else if (raddr1 == `RegNumLog2'h0) begin
          rdata1 <= `ZeroWord;
        end else if ((raddr1 == waddr) && (we == `WriteEnable) && (re1 == `ReadEnable)) begin
          rdata1 <= wdata;
        end else if (re1 == `ReadEnable) begin
          rdata1 <= regs[raddr1];
        end else begin
           rdata1 <= `ZeroWord;
       end
      end
      
    always @ (*) begin
    	if(rst == `RstEnable) begin
    	  rdata2 <= `ZeroWord;
    	end else if(raddr2 == 5'h0) begin
    	  rdata2 <= `ZeroWord;
    	end else if((raddr2 == waddr) && (we == `WriteEnable) && (re2 == `ReadEnable)) begin
    	  rdata2 <= wdata;
    	end else if(re2 == `ReadEnable) begin
    	  rdata2 <= regs[raddr2];
    	end else begin
    	  rdata2 <= `ZeroWord;
        end
      end

//`define READ(re, raddr, rdata)  \
//    always @ (*) begin  \
//    	if(rst == `RstEnable) begin    \
//    	  rdata <= `ZeroWord;  \
//    	end else if(raddr == 5'h0) begin   \
//    	  rdata <= `ZeroWord;  \
//    	end else if((raddr == waddr) && (we == `WriteEnable) && (re == `ReadEnable)) begin \
//    	  rdata <= wdata;  \
//    	end else if(re == `ReadEnable) begin   \
//    	  rdata <= regs[raddr];    \
//    	end else begin \
//    	  rdata <= `ZeroWord;  \
//        end \
//      end
      
//   `READ(re1,raddr1,rdata1)
//   `READ(re2,raddr2,rdata2)
   
endmodule // regfile


`endif
