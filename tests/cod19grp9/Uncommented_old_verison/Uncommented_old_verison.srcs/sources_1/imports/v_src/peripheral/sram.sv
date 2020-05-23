`include "per_defs.svh"
`timescale 1ns/1ps
//`include "E:/project_1/project_1.srcs/sources_1/new/per_defs.svh"
/*
module sram(
	Bus_if.slave inst_bus,
	Bus_if.slave data_bus,
	Sram_if.master base_ram,
	Sram_if.master ext_ram,
	CPLD_uart_if.master cpld,
	output wire[31:0] inst_op
);

interface Sram_if();
    wire Word data;
    SramChipAddress address;
    logic[3:0] be;
    logic ce, oe, we;
    modport master(
        output address, be, ce, oe, we,
        inout  data
    );
endinterface

interface CPLD_uart_if();
    logic wrn, rdn;
    logic data_ready,tsre,tbre;
    modport master(
        output wrn,rdn,
        input data_ready,tsre,tbre
    );
endinterface

*/

module sram(
    Bus_if.slave inst_bus,
	Bus_if.slave data_bus,
	output wire[3:0] base_ram_be_n,ext_ram_be_n,
	output wire[`SRAM_CHIP_ADDRESS_WIDTH-1 : 0] base_ram_addr,ext_ram_addr,
	output wire base_ram_ce_n,base_ram_oe_n,base_ram_we_n,
	output wire ext_ram_ce_n,ext_ram_oe_n,ext_ram_we_n,
	output wire base_ram_write,ext_ram_write,
	output wire Word base_ram_data_o,ext_ram_data_o,
	input wire Word base_ram_data_i,ext_ram_data_i,
	output wire wrn,rdn,
	input wire dataready,tsre,tbre
);

wire clk,rst,clk_bus;
assign clk_bus = inst_bus.clk.base;
assign clk = inst_bus.clk.base_2x;
assign rst = inst_bus.clk.rst;

assign inst_bus.stall = `ZERO_BIT;

//logic ram_write;

//Word base_ram_data,ext_ram_data;
assign base_ram_data_o = data_bus.data_w;
assign ext_ram_data_o = data_bus.data_w;

wire data_even,inst_even;
assign inst_even = (inst_bus.address[`RAM_ADDRESS_WIDTH -1] == 0);
assign data_even = (data_bus.address[`RAM_ADDRESS_WIDTH -1] == 0);

logic last_data_even,last_data_bus_read;
logic last_uart_req,last_use_uart;
logic last_stall;
logic uart_req;

assign uart_req = (data_bus.address[0] == 1'b0) ? 1'b1 : 1'b0;

Word data_read,uart_read;
assign data_read = data_bus.read ? (data_even ? base_ram_data_i : ext_ram_data_i) : `ZERO_WORD;
assign uart_read = last_use_uart ? (uart_req ? {24'b0, base_ram_data_i[7:0]} : { 30'b0, dataready, tsre & tbre }) : `ZERO_WORD;
//assign uart_read = last_use_uart ? (uart_req ? {24'b0, base_ram_data_i[7:0]} : { 30'b0, 1'b1, tsre & tbre}) : `ZERO_WORD;
assign last_use_uart = data_bus.use_cpld_uart & data_bus.read;
assign data_bus.data_r2 = `ZERO_WORD;
//assign inst_bus.data_r2 = `ZERO_WORD;

SramChipAddress inst_addr_half,data_addr_half;
assign inst_addr_half = SramChipAddress'(inst_bus.address);
assign data_addr_half = SramChipAddress'(data_bus.address);

logic interrupt;

`REGISTER_IRQ(UART,interrupt,data_bus.interrupt)

assign interrupt = dataready;

/*
always_ff @(posedge clk or posedge rst) begin
	if(rst) begin
		base_ram.ce <= 1'b1;
		base_ram.oe <= 1'b1;
		base_ram.we <= 1'b1;
		ext_ram.ce <= 1'b1;
		ext_ram.oe <= 1'b1;
		ext_ram.we <= 1'b1;
		ram_write <= 1'b0;
		last_stall <= 1'b0;
            	last_data_even <= 1'b0;
            	last_data_bus_read <= 1'b0;
            	data_bus.data_r1 <= `ZERO_WORD;
            	data_bus.stall <= 1'b0;
            	inst_bus.data_r1 <= `ZERO_WORD;
            	inst_bus.data_r2 <= `ZERO_WORD;
            	cpld.rdn <= 1'b1;
            	cpld.wrn <= 1'b1;
	end else begin
            if(clk_bus == `BUS_CLK_POSEDGE) begin
                last_data_even <= data_even;
                last_data_bus_read <= data_bus.read;
                last_stall <= data_bus.stall;
                last_use_uart <= data_bus.use_cpld_uart & data_bus.read;
                last_uart_req <= uart_req;
                inst_bus.data_r1 <= inst_even ? base_ram.data : ext_ram.data;
                inst_bus.data_r2 <= inst_even ? ext_ram.data : base_ram.data;
                base_ram.ce <= 1'b0;
                base_ram.we <= 1'b1;
                base_ram.oe <= 1'b0;
                ext_ram.ce <= 1'b0;
                ext_ram.we <= 1'b1;
                ext_ram.oe <= 1'b0;
                cpld.rdn <= 1'b1;
            	cpld.wrn <= 1'b1;
                
                if(data_bus.stall) begin
                    ram_write <= data_bus.write;
                    base_ram.ce <= data_bus.use_cpld_uart;
                    base_ram.oe <= ~(data_bus.read & data_even);
                    base_ram.we <= ~(data_bus.write & data_even);
                    base_ram.be <= ~data_bus.mask;
                    cpld.rdn <= ~(data_bus.read & data_bus.use_cpld_uart & uart_req);
            	    cpld.wrn <= ~(data_bus.write & data_bus.use_cpld_uart & uart_req);
                    base_ram_data <= data_bus.data_w;
                    base_ram.address <= data_addr_half;
                    ext_ram.ce <= 1'b0;
                    ext_ram.oe <= ~(data_bus.read & ~data_even);
                    ext_ram.we <= ~(data_bus.write & ~data_even);
                    ext_ram.be <= ~data_bus.mask;
                    ext_ram_data <= data_bus.data_w;
                    ext_ram.address <= data_addr_half;
                end
            end else begin
                ram_write <= 1'b0;
                data_bus.data_r1 <= last_use_uart ? uart_read : data_read;
                if (last_stall) data_bus.stall <= 1'b0;
                else data_bus.stall <= (data_bus.read | data_bus.write);
                
                cpld.rdn <= 1'b1;
                cpld.wrn <= 1'b1;
                base_ram.we <= 1'b1;
                        base_ram.ce <= 1'b0;
                        base_ram.be <= 4'b0000;
                        base_ram.oe <= 1'b0;
                        ext_ram.we <= 1'b1;
                        ext_ram.ce <= 1'b0;
                        ext_ram.be <= 4'b0000;
                        ext_ram.oe <= 1'b0;
                        //base_ram.address <= inst_even ? inst_addr_half : (inst_addr_half + 1'b1);
                        base_ram.address <= inst_addr_half;
                        ext_ram.address <= inst_addr_half;
                        
            end
	end
end
*/

reg[19:0] base_ram_address,ext_ram_address;
reg base_ram_ce,base_ram_oe,base_ram_we,ext_ram_ce,ext_ram_oe,ext_ram_we;
reg[3:0] base_ram_be,ext_ram_be;
reg cpld_rdn,cpld_wrn;
reg[31:0] data_r,inst_r;

assign base_ram_addr = base_ram_address;
assign ext_ram_addr = ext_ram_address;
assign base_ram_ce_n = base_ram_ce;
assign base_ram_oe_n = base_ram_oe;
assign base_ram_we_n = base_ram_we;
assign base_ram_be_n = base_ram_be;
assign ext_ram_ce_n = ext_ram_ce;
assign ext_ram_oe_n = ext_ram_oe;
assign ext_ram_we_n = ext_ram_we;
assign ext_ram_be_n = ext_ram_be;
assign rdn = cpld_rdn;
assign wrn = cpld_wrn;
assign data_bus.data_r1 = data_r;
assign inst_bus.data_r1 = inst_r;
assign base_ram_write = data_bus.write;
//assign base_ram_write = (data_bus.write & data_even) | ~cpld_wrn;
//assign ext_ram_write = data_bus.write & (~data_even);
//assign ext_ram_write = data_bus.write & cpld_wrn;

assign ext_ram_write = cpld_wrn & (~base_ram_ce & base_ram_oe);


always @(*) begin
    if(rst) begin
        base_ram_address <= 20'b0;
        base_ram_be <= 4'b1111;
        base_ram_ce <= 1'b1;
        base_ram_oe <= 1'b1;
        base_ram_we <= 1'b1;
        ext_ram_address <= 20'b0;
        ext_ram_be <= 4'b1111;
        ext_ram_ce <= 1'b1;
        ext_ram_oe <= 1'b1;
        ext_ram_we <= 1'b1;
        cpld_rdn <= 1'b1;
        cpld_wrn <= 1'b1;
        data_r <= 32'b0;
        inst_r <= 32'b0;
    end else begin
        base_ram_address <= 20'b0;
        base_ram_be <= 4'b1111;
        base_ram_ce <= 1'b1;
        base_ram_oe <= 1'b1;
        base_ram_we <= 1'b1;
        ext_ram_address <= 20'b0;
        ext_ram_be <= 4'b1111;
        ext_ram_ce <= 1'b1;
        ext_ram_oe <= 1'b1;
        ext_ram_we <= 1'b1;
        cpld_rdn <= 1'b1;
        cpld_wrn <= 1'b1;
        data_r <= 32'b0;
        inst_r <= 32'b0;
        
        if(data_bus.read | data_bus.write) begin
            if(data_even & ~data_bus.use_cpld_uart) begin
                base_ram_ce <= 1'b0;
                base_ram_oe <= ~data_bus.read;
                base_ram_we <= ~data_bus.write;
                base_ram_be <= ~data_bus.mask;
                base_ram_address <= data_addr_half;
            end else if(~data_even & ~data_bus.use_cpld_uart) begin
                ext_ram_ce <= 1'b0;
                ext_ram_oe <= ~data_bus.read;
                ext_ram_we <= ~data_bus.write;
                ext_ram_be <= ~data_bus.mask;
                ext_ram_address <= data_addr_half;
            end else if(uart_req) begin
                cpld_rdn <= ~data_bus.read;
                cpld_wrn <= ~data_bus.write;
            end
            if(data_bus.read) begin
                data_r <= last_use_uart ? uart_read : data_read;
            end
       end else begin
            cpld_rdn <= 1'b1;
            cpld_wrn <= 1'b1;
            if(inst_even) begin
                base_ram_we <= 1'b1;
                base_ram_ce <= 1'b0;
                base_ram_be <= 4'b0000;
                base_ram_oe <= 1'b0;
                base_ram_address <= inst_addr_half;
                inst_r <= base_ram_data_i;
            end else begin
                ext_ram_we <= 1'b1;
                ext_ram_ce <= 1'b0;
                ext_ram_be <= 4'b0000;
                ext_ram_oe <= 1'b0;
                ext_ram_address <= inst_addr_half;
                inst_r <= ext_ram_data_i;
            end
        end
    end
end




endmodule
