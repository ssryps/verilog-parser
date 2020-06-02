`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.11.2019 00:03:41
// Design Name: 
// Module Name: ctrl
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

module ctrl(
    input wire                   clk,
	input wire					rst,
	input wire                   stallreq_from_id,
	input wire                   stallreq_from_ex,
	input wire                   stallreq_from_mem,
	
	input wire[31:0]             excepttype_i,
	input wire[`RegBus]          cp0_epc_i,
//	input wire                 uart_ce_i,          // NEW 
//	input wire                 uart_clear_pause_i, // NEW
	input wire                 uart_busy_i,
    input wire                  mem_we_i,
    input wire                  is_load_i,
    output reg                  mem_we_o,
    
	output reg[`RegBus]          new_pc,
	output reg                  flush,
	output reg[5:0]              stall       
	
);
    
    reg pause_for_store;
    reg pause_for_load;

    always @(posedge clk) begin
        if (rst == `RstEnable)
            pause_for_store <= 1'b0;
        else if (uart_busy_i == 1'b1 || mem_we_i == 1'b0)
            pause_for_store <= 1'b0;
        else if (mem_we_i == 1'b1)
            pause_for_store <= 1'b1;
    end

    always @(posedge clk) begin
        if (rst == `RstEnable)
            pause_for_load <= 1'b0;
        else if (is_load_i == 1'b1)
            pause_for_load <= 1'b1;
        else 
            pause_for_load <= 1'b0;
    end
    
	always @ (*) begin
		if(rst == `RstEnable) begin
			stall <= 6'b000000;
            mem_we_o <= 1'b0;
        end else if(excepttype_i != `ZeroWord) begin
		    flush <= 1'b1;
		    stall <= 6'b000000;
            mem_we_o <= 1'b0;
			case (excepttype_i)
				32'h00000001:		begin   //interrupt
					new_pc <= 32'h00000020;
				end
				32'h00000008:		begin   //syscall
					new_pc <= 32'h00000040;
				end
				32'h0000000a:		begin   //inst_invalid
					new_pc <= 32'h00000040;
				end
				32'h0000000e:		begin   //eret
					new_pc <= cp0_epc_i;
				end
				default	: begin
				end
			endcase 	
		end else if(stallreq_from_ex == `Stop) begin
			stall <= 6'b001111;
			flush <= 1'b0;
            mem_we_o <= 1'b0;
		end else if(stallreq_from_id == `Stop) begin
			stall <= 6'b000111;	
			flush <= 1'b0;		
            mem_we_o <= 1'b0;
		end else if (mem_we_i == 1'b1 && pause_for_store == 1'b0) begin
            stall <= 6'b011111;
            flush <= 1'b0;
            mem_we_o <= 1'b0;
        end else if (mem_we_i == 1'b1 && pause_for_store == 1'b1) begin
            stall <= 6'b001111;
            flush <= 1'b0;
            mem_we_o <= 1'b1;
        end else if (is_load_i == 1'b1 && pause_for_load == 1'b0) begin
            stall <= 6'b001111;
            flush <= 1'b0;
            mem_we_o <= 1'b0;
        end else if (is_load_i == 1'b1 && pause_for_load == 1'b1) begin
            stall <= 6'b000111;
            flush <= 1'b0;
            mem_we_o <= 1'b0;
        end else if (stallreq_from_mem == `Stop) begin
            stall <= 6'b001111;
            flush <= 1'b0;
            mem_we_o <= 1'b0;
        end else begin
			stall <= 6'b000000;
			flush <= 1'b0;
			new_pc <= `ZeroWord;
            mem_we_o <= 1'b0;
		end    //if
	end      //always
			

endmodule
