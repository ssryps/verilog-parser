`include "per_defs.svh"

module flash(
	Bus_if.slave data_bus,
	Flash_if.master flash_t
);

`define WAIT_CYCLES 4

assign flash_t.vpen = 1'b0;
assign flash_t.byte_n = 1'b1;
assign flash_t.rp = 1'b1;

wire clk, clk_bus, rst;
assign clk = data_bus.clk.base_2x;
assign bus_clk = data_bus.clk.base;
assign rst = data_bus.clk.rst;

typedef enum {
	INIT,RESET,WRITE_BYTE_[`WAIT_CYCLES],
	READ_BYTE_0_[`WAIT_CYCLES],READ_BYTE_1_[`WAIT_CYCLES]
}FlashState;

`undef WAIT_CYCLES

FlashState state;

Word data_read;
FlashChipAddress chipAddress;
assign chipAddress = FlashChipAddress'(data_bus.address << 2);

HalfWord data_write;
logic write_flash;
assign flash_t.data = write_flash ? data_write : `HIGHZ_HWORD;
assign data_bus.data_r1 = data_read;

logic write_up;
assign write_up = ~(|data_bus.mask[1:0]);

`define GEN_WAIT_STATE(NAME,F,T) NAME``_``F:begin \
	state <= NAME``_``T;\
end \

`define GEN_WAIT_STATES(NAME) `GEN_WAIT_STATE(NAME,0,1) \
`GEN_WAIT_STATE(NAME,1,2) \
`GEN_WAIT_STATE(NAME,2,3) \

always_ff @(posedge clk or posedge rst) begin
	if(rst) begin
		state <= RESET;
		write_flash <= `ZERO_BIT;
		data_read <= `ZERO_WORD;
		flash_t.ce <= 1'b1;
		flash_t.we <= 1'b1;
		flash_t.oe <= 1'b1;
		data_bus.stall <= `ZERO_BIT;
	end else begin
		if(bus_clk == ~`BUS_CLK_POSEDGE) begin
			unique case(state)
				RESET:begin
					write_flash <= 1'b1;
					data_write <= `FLASH_OP_READ;
					flash_t.ce <= 1'b0;
					flash_t.we <= 1'b0;
					flash_t.oe <= 1'b1;
					flash_t.address <= 0;
					state <= WRITE_BYTE_0;
				end

				INIT:begin
					write_flash <= `ZERO_BIT;
					flash_t.ce <= 1'b0;
					flash_t.we <= 1'b0;
					flash_t.oe <= 1'b1;
					if(data_bus.read) begin
						data_bus.stall <= 1'b1;
						flash_t.ce <= 1'b0;
						flash_t.oe <= 1'b0;
						flash_t.address <= chipAddress;
						state <= READ_BYTE_0_0;
					end
					else if(data_bus.write) begin
						data_bus.stall <= 1'b1;
						flash_t.ce <= 1'b0;
						flash_t.we <= 1'b0;
						flash_t.address <= write_up ? chipAddress + 2'h2 : chipAddress;
						write_flash <= 1'b1;
						data_write <= write_up ? data_bus.data_w[16 +: 16] : data_bus.data_w[0 +: 16];
						state <= WRITE_BYTE_0;
					end
				end
				
				`GEN_WAIT_STATES(READ_BYTE_0)

				READ_BYTE_0_3:begin
					data_read[15:0] <= flash_t.data;
					flash_t.address <= chipAddress + 2'h2;
					state <= READ_BYTE_1_0;
				end

				`GEN_WAIT_STATES(READ_BYTE_1)

				READ_BYTE_1_3:begin
					data_bus.stall <= `ZERO_BIT;
					data_read[31:16] <= flash_t.data;
					flash_t.ce <= 1'b1;
					flash_t.we <= 1'b1;
					flash_t.oe <= 1'b1;
					state <= INIT;
				end

				`GEN_WAIT_STATES(WRITE_BYTE)

				WRITE_BYTE_3:begin
					data_bus.stall <= `ZERO_BIT;
					flash_t.ce <= 1'b1;
					flash_t.we <= 1'b1;
					flash_t.oe <= 1'b1;
					state <= INIT;
				end

				default: state <= INIT;
			endcase
		end
	end
end

`undef GEN_WAIT_STATE
`undef GEN_WAIT_STATES

endmodule
