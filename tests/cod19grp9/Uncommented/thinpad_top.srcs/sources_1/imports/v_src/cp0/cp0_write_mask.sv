`include "cp0_defs.svh"

module cp0_write_mask (
	input rst,
	input [2:0] sel,
	input logic [4:0] addr,
	output logic [31:0] mask
);

logic[31:0] tlb_index_mask;
assign tlb_index_mask = 32'h0000000f;

always_comb begin
	if(rst) begin
		mask = 32'b0;
	end else if (sel == 3'd0) begin
		unique case(addr)
			5'b00000: mask = 32'h0000001f; // index
			5'b00001: mask = 32'h00000000; // random
			5'b00010: mask = 32'h3fffffff; // entry_lo0
			5'b00011: mask = 32'h3fffffff; // entry_lo1
			5'b00100: mask = 32'hff000000; // context
			5'b00101: mask = 32'h1fffe000; // page_mask
			5'b00110: mask = 32'h0000001f; // wired
			5'b01000: mask = 32'h00000000; // bad_v_addr
			5'b01001: mask = 32'hffffffff; // count
			5'b01010: mask = 32'hfffff0ff; // entry_hi
			5'b01011: mask = 32'hffffffff; // compare
			5'b01100: mask = 32'hfa78ff17; // status
			5'b01101: mask = 32'h00c00300; // cause
			5'b01110: mask = 32'hffffffff; // epc
			5'b01111: mask = 32'h00000000; // prid
			5'b10000: mask = 32'h00000007; // config0
			5'b11110: mask = 32'hffffffff; // error_epc
			default: mask = 32'b0;
		endcase
	end else begin
		mask = 32'b0;
	end
end



endmodule