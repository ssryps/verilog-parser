`include "cp0_defs.svh"
`include "../except_defs.svh"
`include "cp0_write_mask.sv"

module cp0_reg (
	input logic		clk,
	input logic		rst,
	input logic [4:0]  raddr,
	input logic [2:0]	rsel,
	input CP0_writeRequest_t write_register_request,
	input Except_request_t	except_req,
	
	output CP0_regs_t	regs,
	output logic [31:0]	rdata,
	output logic		user_mode,
	output reg		timer_int
);

CP0_regs_t regs_new, regs_inner;
assign regs = regs_inner;
assign user_mode = (regs.status[4:1] == 4'b1000);

always_comb
begin
	if(rsel == 3'b0)
	begin
		rdata = regs[raddr * 32 +: 32];
	end else begin
		rdata = 32'b0;
	end
end

always @(posedge clk) begin
	if(rst) begin
		/*Initialize the value of registers*/
		regs_inner.index <= 32'h0;
		// regs_inner.random
		regs_inner.entry_lo1 <= 32'h0;
		regs_inner.entry_lo0 <= 32'h0;
		regs_inner.context0 <= 32'h0;
		regs_inner.page_mask <= 32'h0;
		regs_inner.wired <= 32'h0;
		regs_inner.bad_v_addr <= 32'h0;
		regs_inner.count <= 32'h0;
		regs_inner.entry_hi <= 32'h0;
		regs_inner.compare <= 32'h0;
		regs_inner.status <= 32'b00010000010000000000000000000000;
		regs_inner.cause <= 32'h0;
		regs_inner.epc <= 32'h0;
		regs_inner.prid <= 32'h0;
		regs_inner.config0 <= 32'b00000000000000001000000000000000;
		regs_inner.error_epc <= 32'h0;
		regs_inner.ebase <= 32'h80000001;
	end else begin
		regs_inner <= regs_new;
	end
end

logic [31:0] write_mask, write_data;

always @(posedge clk) begin
	if(rst)
		timer_int <= 1'b0;
	else if(regs.compare != 32'h0 && regs.compare == regs.count)
		timer_int <= 1'b1;
end


cp0_write_mask cp0_write_mask_instance(
	.rst,
	.sel(write_register_request.sel),
	.addr(write_register_request.waddr),
	.mask(write_mask)
);

always_comb begin
	regs_new = regs_inner;
	regs_new.count = regs_new.count + 32'b1;

	/*write register*/
	if(write_register_request.we) begin
		if(write_register_request.sel == 3'b0) begin
			write_data = regs_new[write_register_request.waddr * 32 +: 32];
			write_data = (write_register_request.wdata & write_mask) | (write_data & ~write_mask);
			regs_new[write_register_request.waddr * 32 +: 32] = write_data;
		end else if(write_register_request.sel == 3'b1) begin 
			if(write_register_request.waddr == 5'd15) 
				regs_new.ebase[29:12] = write_register_request.wdata[29:12];
		end
	end

	/*Exception*/
	if(except_req.flush) begin
		if(except_req.eret) begin
			if(regs_new.status.erl)
				regs_new.status.erl = 1'b0;
			else
				regs_new.status.exl = 1'b0;
		end else begin
			if(regs_new.status.exl == 1'b0) begin
				if(except_req.delayslot) begin
					regs_new.epc = except_req.current_pc - 32'h00000004;
					regs_new.cause.bd = 1'b1;
				end else begin
					regs_new.epc = except_req.current_pc;
					regs_new.cause.bd = 1'b0;
				end
			end

			regs_new.status.exl = 1'b1;
			regs_new.cause.ce = except_req.extra[1:0];
			regs_new.cause.exc_code = except_req.code;
			if(except_req.code == `EXC_CODE_INT) begin
				regs_new.cause.ip = except_req.extra[7:0];
			end else if(except_req.code == `EXC_CODE_ADDE_LOAD || except_req.code == `EXC_CODE_ADDE_STORE) begin
				regs_new.bad_v_addr = except_req.extra;
			end else if(except_req.code == `EXC_CODE_TLB_LOAD || except_req.code == `EXC_CODE_TLB_STORE) begin
				regs_new.bad_v_addr = except_req.extra;
				regs_new.context0[22:4] = except_req.extra[31:13]; // context0.bad_vpn2
				regs_new.entry_hi[31:13] = except_req.extra[31:13]; // entry_hi.vpn2
			end else begin end
		end
	end
end

endmodule