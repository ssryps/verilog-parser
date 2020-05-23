`include "per_defs.svh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/28 22:30:24
// Design Name: 
// Module Name: data_bus
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


module data_bus(
	Bus_if.slave cpu,
	Bus_if.master flash,
	Bus_if.master ram,
	Bus_if.master bootrom,
	Bus_if.master uart,
	Bus_if.master vga
    );

assign cpu.interrupt = uart.interrupt;
assign ram.data_w = cpu.data_w;
assign ram.address = cpu.address[2 +: `RAM_ADDRESS_WIDTH];
assign ram.mask = cpu.mask;

assign bootrom.data_w = `ZERO_WORD;
assign bootrom.address = cpu.address[2 +: `BOOTROM_ADDRESS_WIDTH];
assign bootrom.mask = `BYTE_MASK_FULL;

assign flash.data_w = cpu.data_w;
assign flash.address = cpu.address[2 +: `FLASH_ADDRESS_WIDTH];
assign flash.mask = cpu.mask;

assign uart.data_w = cpu.data_w;
assign uart.address = cpu.address[2 +: `UART_ADDRESS_WIDTH];

assign vga.data_w = cpu.data_w;
assign vga.address = cpu.address;

always_comb begin


	// for peripheral
	bootrom.read = `ZERO_BIT;
	bootrom.write = `ZERO_BIT;
	ram.read = `ZERO_BIT;
	ram.write = `ZERO_BIT;
	flash.read = `ZERO_BIT;
	flash.write = `ZERO_BIT;
	uart.read = `ZERO_BIT;
	uart.write = `ZERO_BIT;

	//for cpu
	cpu.data_r1 = `ZERO_WORD;
	cpu.data_r2 = `ZERO_WORD;
	cpu.stall = `ZERO_BIT;

	unique casez (cpu.address[(`ADDRESS_WIDTH-1) -: `LONGEST_ADDRESS_PREFIX_WIDTH])

		`ADD_PREFIX(BOOTROM):begin
			bootrom.read = cpu.read;
			cpu.data_r1 = bootrom.data_r1;
			cpu.stall = bootrom.stall;
		end

		`ADD_PREFIX(RAM):begin
			ram.read = cpu.read;
			ram.write = cpu.write;
			ram.use_cpld_uart = 1'b0;
			cpu.data_r1 = ram.data_r1;
			cpu.stall = ram.stall;
		end

		`ADD_PREFIX(FLASH):begin
			flash.read = cpu.read;
			flash.write = cpu.write;
			cpu.data_r1 = flash.data_r1;
			cpu.stall = flash.stall;
		end

		`ADD_PREFIX(UART):begin
		/*
			uart.read = cpu.read;
			uart.write = cpu.write;
			cpu.data_r1 = uart.data_r1;
		*/
		    ram.read = cpu.read;
			ram.write = cpu.write;
			ram.use_cpld_uart = 1'b1;
			cpu.data_r1 = ram.data_r1;
			cpu.stall = ram.stall;
		end
		
		`ADD_PREFIX(VGA):begin
		    vga.write = cpu.write;
		 end
		
		default:begin end
		
	endcase
end

endmodule