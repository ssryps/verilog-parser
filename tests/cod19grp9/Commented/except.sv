`include "except_defs.svh"
`include "./cp0/cp0_defs.svh"

module except (
	input rst,
	input Pipeline_data_t data,
	input logic is_user_mode,
	input Except_info_t except,
	input CP0_regs_t cp0_regs_input,
	input memory_data_writeEnable, 
	input logic [31:0] data_virtual_addr, 
	input CP0_writeRequest_t cp0_write_req,
	input wire [7:0] interrupt_flag,
	output Except_request_t except_req
);

logic [31:0] cp0_reg_mask, cp0_reg_data;

cp0_write_mask cp0_write_mask_instance(
	.rst,
	.sel(cp0_write_req.sel),
	.addr(cp0_write_req.waddr),
	.mask(cp0_reg_mask)
);

CP0_regs_t cp0_regs;

always_comb begin
	cp0_regs = cp0_regs_input;
	if(cp0_write_req.we) begin
		cp0_reg_data = cp0_regs[cp0_write_req.waddr * 32 +: 32];
		cp0_reg_data = (cp0_write_req.wdata & cp0_reg_mask) | (cp0_reg_data & ~cp0_reg_mask);
		cp0_regs[cp0_write_req.waddr * 32 +: 32] = cp0_reg_data;
	end else begin end
end

logic [31:0] pc;

logic interrupt_occur;
logic except_occur;
logic [4:0] except_code;

assign interrupt_occur = 1'b0;

//assign is_interrupt = cp0_regs.status.ie && ~cp0_regs.status.exl && ~cp0_regs.status.erl && interrupt_flag != 8'b0;

always_comb begin
	except.priv_inst = except.priv_inst && is_user_mode;
	except_occur = (|except) | interrupt_occur;
	if(interrupt_occur) begin
		except_code = `EXC_CODE_INT;
		except_req.extra = interrupt_flag;
	end else if(except.inst_addr_illegal) begin
		except_code = `EXC_CODE_ADDE_LOAD;
		except_req.extra = data.pc;
	end else if(except.inst_addr_miss) begin
		except_code = `EXC_CODE_TLB_LOAD;
		except_req.extra = data.pc;
	end else if(except.inst_addr_invalid) begin
		except_code = `EXC_CODE_TLB_LOAD;
		except_req.extra = data.pc;	
	end else if(except.syscall) begin
		except_code = `EXC_CODE_SYSCALL;
	end else if(except.break0) begin
		except_code = `EXC_CODE_BP;
	end else if(except.overflow) begin
		except_code = `EXC_CODE_OV;
	end else if(except.trap) begin
		except_code = `EXC_CODE_TRAP;
	end else if(except.eret) begin
		except_code = 5'b0;
	end else if(except.priv_inst) begin
		except_code = `EXC_CODE_CpU;
		except_req.extra = 32'b1;
	end else if(except.invalid_inst) begin
		except_code = `EXC_CODE_RI;
	end else if(except.data_addr_unaligned || except.data_addr_illegal) begin
		except_code = memory_data_writeEnable? `EXC_CODE_ADDE_STORE : `EXC_CODE_ADDE_LOAD ;
		except_req.extra = data_virtual_addr;
	end else if(except.data_addr_miss) begin
		except_code = memory_data_writeEnable? `EXC_CODE_TLB_STORE : `EXC_CODE_TLB_LOAD ;
		except_req.extra = data_virtual_addr;
	end else if(except.data_addr_invalid) begin
		except_code = memory_data_writeEnable? `EXC_CODE_TLB_STORE : `EXC_CODE_TLB_LOAD ;
		except_req.extra = data_virtual_addr;
	end else if(except.data_addr_read_only) begin
		except_code = `EXC_CODE_TLB_MODI;
		except_req.extra = data_virtual_addr;
	end else begin
		except_code = 5'b0;
	end
end

always_comb begin
	pc = data.pc;
	except_req.delayslot = data.delayslot;
end

always_comb begin
	if(rst || ~except_occur) begin
		except_req.flush = 1'b0;
		except_req.code = 5'b0;
		except_req.eret = 1'b0;
		except_req.current_pc = 32'b0;
		except_req.jump_pc = 32'b0;
	end else begin
		except_req.flush = 1'b1;
		except_req.code = except_code;
		except_req.current_pc = pc;
		except_req.eret = except.eret;
		if(except.eret) begin
			if(cp0_regs.status.erl)
				except_req.jump_pc = cp0_regs.error_epc;
			else
				except_req.jump_pc = cp0_regs.epc;
		end else begin
			logic [11:0] offset;
			if(cp0_regs.status.exl == 1'b0) begin
				if(except_code == `EXC_CODE_TLB_STORE || except_code == `EXC_CODE_TLB_LOAD) begin
					offset = 12'h000;
				end else if(except_code == `EXC_CODE_INT && cp0_regs.cause.iv) begin
					offset = 12'h200;
				end else begin
					offset = 12'h180;
				end
			end else begin
				offset = 12'h180;
			end

			if(cp0_regs.status.bev)
				// except_req.jump_pc = 32'hbfc00200 + offset;
				except_req.jump_pc = 32'h00000010;
			else
				except_req.jump_pc = {cp0_regs.ebase[31:12], offset};
		end
	end
end

endmodule
