`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.11.2019 02:51:28
// Design Name: 
// Module Name: inst_rom
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


module inst_rom(
		input wire 		  ce,
		input wire [`InstAddrBus] addr,
		output reg [`InstBus] 	  inst
	      );


parameter TEST_FILE = "D:\\mips32lab\\mycode\\testcases";  // change name of test file

reg [31:0] tmp_array[0:100];
reg [31:0] inst_mem[0:100];

integer n_File_ID, n_Init_Size;
integer i;
initial
  begin
    n_File_ID = $fopen(TEST_FILE, "rb");
    if(!n_File_ID)begin 
        n_Init_Size = 0;
        $display("Failed to open test file");
    end
    else begin
        n_Init_Size = $fread(tmp_array, n_File_ID);
        $fclose(n_File_ID);
    end
    
    for (i = 0; i < n_Init_Size/4; i = i + 1) begin
        inst_mem[i] =  {tmp_array[i][0+:8], tmp_array[i][8+:8], tmp_array[i][16+:8], tmp_array[i][24+:8]};
    end
  end


   always @ (*)
     begin
	if (ce == `ChipDisable) inst <= `ZeroWord;
	else
	  inst <= inst_mem[addr[`InstMemNumLog2+1:2]];
     end

endmodule
