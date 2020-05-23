`include "mmu_defs.svh"



module mmu (
	input clk, rst,
	input wire is_user_mode,
	input logic [7:0] asid,
	input logic [31:0] inst_virtual_addr,
	input logic [31:0] data_virtual_addr,  // Harvard
	
	output MMU_return_t inst_return,
	output MMU_return_t data_return
);

generate if(1)
begin : MMU_enable_mode
	function logic ismapped(
		input logic [31:0] input_virtual_addr
	);
		// useg, kseg2, kseg3
		return (~input_virtual_addr[31] || (input_virtual_addr[31] && input_virtual_addr[30]));
	endfunction

	assign inst_mapped = ismapped(inst_virtual_addr);
	assign data_mapped = ismapped(data_virtual_addr);

	assign inst_return.virtual_addr = inst_virtual_addr;

	assign data_return.virtual_addr = data_virtual_addr;

end

else begin : MMU_disable_mode
	always_comb begin
		inst_return = {$bits(MMU_return_t){1'b0}};
		data_return = {$bits(MMU_return_t){1'b0}};
		inst_return.physic_addr = inst_virtual_addr;
		data_return.physic_addr = data_virtual_addr;
	end
end
endgenerate


endmodule