`ifndef CP0_DEFS_SVH
`define CP0_DEFS_SVH

typedef struct packed {
	logic cu3, cu2, cu1, cu0;
	logic rp, fr, re, mx; // mx = 0? from CPU_write
	logic px, bev, ts, sr; // px = 0? from CPU_write and mips_vol3
	logic nmi, ase; // ase = 0? from CPU_write
	logic [1:0] impl; // impl = 0? from CPU_write
	logic [7:0] im;
	logic kx, sx, ux, um; // kx, sx, ux = 0? from mips_vol3
	logic r0, erl, exl, ie;
} CP0Reg_Status_t;

typedef struct packed {
	logic bd, ti;  // ti = 0? from Harry
	logic [1:0] ce;
	logic dc, pci; // 0? from Harry
	logic [1:0] ase; // 0? from Harry and CP0_write
	logic iv, wp, fdci; // fdci = 0? from Harry and CP0_write
	logic [3:0] zero20_17;
	logic ase2; // 0? from Harry and CP0_write
	logic [7:0] ip;
	logic zero7;
	logic [4:0] exc_code;
	logic [1:0] zero1_0;
} CP0Reg_Cause_t;

typedef struct packed {
	logic [31:0] ebase, config1;
	/*primary 32 registers, select = 0*/
	logic [31:0] 
	 desave, error_epc, tag_hi, tag_lo,
	 cache_err, err_ctl, perfor_cnt, depc,
	 debug, reserved_impl, reserved21, reserved20,
	 watch_hi, watch_lo, ll_addr, config0,
	 prid, epc;
	CP0Reg_Cause_t cause;
	CP0Reg_Status_t status;
	logic [31:0]
	 compare, entry_hi, count, bad_v_addr,
	 reserved7, wired, page_mask, context0,
	 entry_lo1, entry_lo0, random, index;
} CP0_regs_t;

typedef struct packed {
	logic we;
	logic [4:0] waddr;
	logic [31:0] wdata;
	logic [2:0] sel;
} CP0_writeRequest_t;





typedef enum {
	/* logical instructions */
	OP_AND, OP_OR, OP_XOR, OP_NOR, OP_ANDI, OP_ORI, OP_XORI, OP_LUI,

	/* shift instructions */
	OP_SLL, OP_SLLV, OP_SRL, OP_SRLV, OP_SRA, OP_SRAV,

	/* move instructions */
	OP_MOVN, OP_MOVZ, OP_MFHI, OP_MFLO, OP_MTHI, OP_MTLO,

	/* arithmetic instructions */
	OP_ADD, OP_ADDU, OP_ADDI, OP_SUB, OP_SUBU, OP_SLT, OP_SLTU, OP_SLTI, OP_MUL, OP_MULT, OP_MULTU,

	/* jump instructions */
	OP_JR, OP_JALR, OP_J, OP_JAL,

	/* branch instructions */
	OP_B, OP_BAL, OP_DEQ, OP_BGEZ, OP_BGEZAL, OP_BGTZ, OP_BLEZ, OP_BLTZ, OP_BLTZAL, OP_BNE,

	/* load instructions */
	OP_LB, OP_LBU, OP_LH, OP_LHU, OP_LW, OP_LWL, OP_LWR,

	/* store instructions */
	OP_SB, OP_SH, OP_SW, OP_SWL, OP_SWR,

	/* control insturctions */
	OP_NOP, OP_PREF, OP_SYNC

} Operator_t;


`endif