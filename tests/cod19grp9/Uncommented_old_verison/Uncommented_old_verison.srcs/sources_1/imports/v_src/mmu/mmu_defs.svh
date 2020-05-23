`ifndef MMU_DEFS_SVH
`define MMU_DEFS_SVH

typedef struct packed {
	logic [31:0]	physic_addr, virtual_addr;
	logic invalid, miss;
} MMU_return_t;

typedef struct packed {
	logic [31:0]	physic_addr;
	logic invalid, miss;
} TLB_return_t;

typedef struct  packed {
	logic [2:0] c0, c1;
	logic [7:0] asid;
	logic [18:0] vpn2;
	logic [23:0] pfn0, pfn1;
	logic d1, d0, v1, v0;
	logic g;
} TLB_one_t;


`endif