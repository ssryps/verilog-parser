`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.11.2019 02:26:38
// Design Name: 
// Module Name: mem_wb
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


`ifdef mem_wb.v
`else
 `define mem_wb.v
 
 `include "defines.v"

module mem_wb(
	      input wire 	       clk,
	      input wire 	       rst,
          
          input wire[5:0]        stall,
          input wire                    flush,
          
        input wire                   mem_cp0_reg_we,
        input wire[4:0]              mem_cp0_reg_write_addr,
        input wire[`RegBus]          mem_cp0_reg_data,	

	      //?自?存?段的信息	
	      input wire [`RegAddrBus] mem_wd,
	      input wire 	       mem_wreg,
	      input wire [`RegBus]     mem_wdata,

	      //送到回??段的信息
	      output reg [`RegAddrBus] wb_wd,
	      output reg 	       wb_wreg,
	      output reg [`RegBus]     wb_wdata	,
	      
	      output reg                   wb_cp0_reg_we,
	       output reg[4:0]              wb_cp0_reg_write_addr,
	       output reg[`RegBus]          wb_cp0_reg_data	       

);

   always @ (posedge clk) 
     begin
	if(rst == `RstEnable) 
	  begin
	     wb_wd <= `NOPRegAddr;
	     wb_wreg <= `WriteDisable;
	     wb_wdata <= `ZeroWord;	
        wb_cp0_reg_we <= `WriteDisable;
        wb_cp0_reg_write_addr <= 5'b00000;
        wb_cp0_reg_data <= `ZeroWord;	
	  end
	else if(flush == 1'b1 ) begin
			wb_wd <= `NOPRegAddr;
			wb_wreg <= `WriteDisable;
		  wb_wdata <= `ZeroWord;
			wb_cp0_reg_we <= `WriteDisable;
			wb_cp0_reg_write_addr <= 5'b00000;
			wb_cp0_reg_data <= `ZeroWord;				  				  	  	
      end  
	else if(stall[4] == `Stop && stall[5] == `NoStop) 
	  begin
	     wb_wd <= `NOPRegAddr;
	     wb_wreg <= `WriteDisable;
	     wb_wdata <= `ZeroWord;	
        wb_cp0_reg_we <= `WriteDisable;
        wb_cp0_reg_write_addr <= 5'b00000;
        wb_cp0_reg_data <= `ZeroWord;	
	  end 
	else if (stall[4] == `NoStop)
	  begin
	     wb_wd <= mem_wd;
	     wb_wreg <= mem_wreg;
	     wb_wdata <= mem_wdata;
	     wb_cp0_reg_we <= mem_cp0_reg_we;
	     wb_cp0_reg_write_addr <= mem_cp0_reg_write_addr;
	     wb_cp0_reg_data <= mem_cp0_reg_data;
	  end // else: !if(rst == `RstEnable)
     end // always @ (posedge clk)

endmodule // mem_wb

`endif
