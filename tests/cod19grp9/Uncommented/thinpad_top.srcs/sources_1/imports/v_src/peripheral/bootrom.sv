//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/21 10:44:25
// Design Name: 
// Module Name: bootrom
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`include "per_defs.svh"

module bootrom(
    Bus_if.slave inst_bus,
    Bus_if.slave data_bus
    );
    
wire clk,rst,bus_clk,bootrom_clk;

assign bus_clk = inst_bus.clk.base;
assign bootrom_clk = inst_bus.clk.base_2x;
assign clk = inst_bus.clk.base_2x;
assign rst = inst_bus.clk.rst;

assign inst_bus.stall = `ZERO_BIT;
logic read_data_n;
Word data_o1,data_o2;;

BootRomAddress base_add1,base_add2;

blk_mem_blockrom bootrom(
    .clka(bootrom_clk),
    .addra(base_add1),
    .douta(data_o1),
    .clkb(bootrom_clk),
    .addrb(base_add2),
    .doutb(data_o2)
);

always_comb begin
    base_add1 = BootRomAddress'(data_bus.address);
    base_add2 = BootRomAddress'(inst_bus.address);
    
    if(rst) begin
        data_bus.data_r1 = `ZERO_WORD;
        inst_bus.data_r1 = `ZERO_WORD;
    end else begin
        data_bus.data_r1 = data_o1;
        inst_bus.data_r1 = data_o2;
    end
end

always_ff @(posedge bootrom_clk or posedge rst) begin
    if (rst) begin
        data_bus.stall <= `ZERO_BIT;
        read_data_n <= `ZERO_BIT;
    end else begin
        data_bus.stall <= ~read_data_n & data_bus.read;
        read_data_n <= data_bus.stall;
    end
end

endmodule
