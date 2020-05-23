`ifndef EXCEPT_DEFS_SVH
`define EXCEPT_DEFS_SVH

`include "./cp0/cp0_defs.svh"

typedef struct packed {
	logic 
	 inst_addr_miss, inst_addr_illegal, inst_addr_invalid, //14 13 12, if, mmu
	 data_addr_miss, data_addr_illegal, data_addr_invalid, //11 10 9, mem, mmu
	 syscall, break0, overflow, priv_inst, //8 7 6 5, ex
	 invalid_inst, trap, eret, //4 3 2, ex
	 data_addr_unaligned, data_addr_read_only;  //1 0, ex, mem, mmu
} Except_info_t;

typedef struct packed {
	logic flush;
	logic delayslot;
	logic eret;
	logic [31:0] current_pc, jump_pc;
	logic [4:0] code;
	logic [31:0] extra;
} Except_request_t;

`define EXC_CODE_INT 5'h00 //interrupt
`define EXC_CODE_TLB_MODI 5'h01 //TLB modification exception
`define EXC_CODE_TLB_LOAD 5'h02 //TLB exception, in loading/instruction fetching
`define EXC_CODE_TLB_STORE 5'h03 //TLB exception, in storing
`define EXC_CODE_ADDE_LOAD 5'h04 //address exception, in loading/instruction fetching
`define EXC_CODE_ADDE_STORE 5'h05 //address exception, in storing
`define EXC_CODE_SYSCALL 5'h08 //syscall
`define EXC_CODE_BP 5'h09 //breakpoint
`define EXC_CODE_RI 5'h0a //reserved instruction exception
`define EXC_CODE_CpU 5'h0b //coprocesser unusable exception
`define EXC_CODE_OV 5'h0c //overflow
`define EXC_CODE_TRAP 5'h0d //trap
`define EXC_CODE_FPE 5'h0f //floating point exception

typedef struct packed {
	logic [31:0] pc;
	logic delayslot;
} Pipeline_data_t;


`endif
