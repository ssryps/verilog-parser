`include "mmu_defs.svh"

module tlb(
	input clk, rst,
	input logic [7:0] asid,
	input logic [31:0] inst_virtual_addr,
	input logic [31:0] data_virtual_addr,
	output TLB_return_t inst_return,
	output TLB_return_t data_return
);



endmodule