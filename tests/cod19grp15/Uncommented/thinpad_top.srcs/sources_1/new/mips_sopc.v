`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.11.2019 02:50:08
// Design Name: 
// Module Name: mips_sopc
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

module mips_sopc(
    input wire clk,
    input wire rst
);			 

    wire [`InstAddrBus] inst_addr;
    wire [`InstBus] inst;
    wire rom_ce;
    
    wire[`RegBus] mem_addr_i;
    wire[`RegBus] mem_data_i;    
    wire[3:0] mem_sel_i;  
    wire mem_ce_i;
    wire mem_we_i;
    wire[`RegBus] mem_data_o;
	wire[5:0] int;
    wire timer_int;

    assign int = {5'b00000, timer_int};
   
   mips mips0(
		      .clk(clk),
		      .rst(rst),              
              // to ROM
		      .rom_addr_o(inst_addr),		      
		      .rom_ce_o(rom_ce),     		      
		      // from ROM
		      .rom_data_i(inst),		                    
              // to RAM
		      .ram_addr_o(mem_addr_i),
		      .ram_data_o(mem_data_i),	      		      
		      .ram_sel_o(mem_sel_i),
		      .ram_we_o(mem_we_i),
		      .ram_ce_o(mem_ce_i),		      
		      // from RAM
		      .ram_data_i(mem_data_o),
			  
			  .int_i(int),
              .timer_int_o(timer_int)
		      );
   
   inst_rom inst_rom0(
		      .addr(inst_addr),
		      .inst(inst),
		      .ce(rom_ce)	
		      );
		      
    data_ram data_ram0(
            .clk(clk),
            .we(mem_we_i),
            .addr(mem_addr_i),
            .sel(mem_sel_i),
            .data_i(mem_data_i),            
            .ce(mem_ce_i),
            //to mips
            .data_o(mem_data_o)		
        );
   
endmodule
