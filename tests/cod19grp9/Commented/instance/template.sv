`include "../macro.v"
`include "connect.sv"
`include "../rom/inst_rom.v"
`include "../ram/data_ram.v"
module template(
    input wire clk,rst
    );
wire[`InstAddrBus] inst_addr;
wire[`InstBus] inst;
wire rom_ce;
wire[`RegBus] ram_data_i,ram_data_o,ram_addr_o;
wire[3:0] ram_sel_o;
wire ram_ce_o, ram_write_enable_o;
connect connect0(.clk(clk), .rst(rst),  .rom_data_i(inst), .ram_data_i(ram_data_i), 
.rom_addr_o(inst_addr), .rom_ce_o(rom_ce), .ram_addr_o(ram_addr_o), .ram_data_o(ram_data_o), .ram_ce_o(ram_ce_o), 
.ram_sel_o(ram_sel_o), .ram_write_enable_o(ram_write_enable_o));
inst_rom inst_rom0(.ce(rom_ce), .addr(inst_addr), .inst(inst));
data_ram data_ram0(.clk(clk), .ce(ram_ce_o), .write_enable(ram_write_enable_o), .addr(ram_addr_o),
.sel(ram_sel_o), .data_i(ram_data_o), .data_o(ram_data_i));
endmodule
