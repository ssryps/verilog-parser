`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.11.2019 02:57:51
// Design Name: 
// Module Name: mips_tb
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

module mips_tb();

   reg CLOCK_50;
   reg     rst;

   integer i;
   
   initial
     begin
	CLOCK_50 = 1'b0;
	forever #10 CLOCK_50 = ~CLOCK_50;
     end

   initial
     begin
	rst = 1'b1;
	#19 rst = 1'b0;
	#1000 $finish;
     end

   mips_sopc mips_sopc0(
    .clk(CLOCK_50),
    .rst(rst)
    );
   
endmodule
