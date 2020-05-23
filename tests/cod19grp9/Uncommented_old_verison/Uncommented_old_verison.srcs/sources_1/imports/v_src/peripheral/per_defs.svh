`ifndef PER_DEFS_SVH
`define PER_DEFS_SVH

`default_nettype wire
`timescale 1ns / 1ps

`ifdef CLOCK_NO_PHASE_SHIFT
`define BUS_CLK_POSEDGE 1'b1
`else
`define BUS_CLK_POSEDGE 1'b0
`endif

typedef logic           Bit_t;
typedef logic [3:0]     Nibble;
typedef logic [3:0]     ByteMask;
typedef logic [5:0]     Interrupt;
typedef logic [7:0]     Byte_t;
typedef logic [15:0]    HalfWord;
typedef logic [31:0]    Word;
typedef logic [63:0]    DoubleWord;



`define ZERO_BIT        1'b0
`define ZERO_BYTE       8'h0
`define ZERO_HWORD      16'h0
`define ZERO_WORD       32'h0
`define ZERO_DWORD      64'h0

`define BYTE_MASK_FULL 4'b1111
`define BYTE_MASK_HALF_LO 4'b0011
`define BYTE_MASK_HALF_HI 4'b1100
`define BYTE_MASK_NONE 4'b0000


`define ADDRESS_WIDTH 32
`define HIGHZ_WORD  {32{1'bZ}}
`define HIGHZ_HWORD {16{1'bZ}}
`define HIGHZ_BYTE {8{1'bZ}}

typedef struct packed {
    logic _50M, _11M0592, _10M;
    logic base, base_2x, base_2x_noshift;
    logic rst;
} Clock_t;

`define IRQ_UART 0

`define RAM_ADDRESS_PREFIX      12'h80?
`define FLASH_ADDRESS_PREFIX    12'h01?
`define VGA_ADDRESS_PREFIX      8'hba
`define UART_ADDRESS_PREFIX     12'hbfd
//`define TIMER_ADDRESS_PREFIX    8'h04
//`define ETHERNET_ADDRESS_PREFIX 8'h05
//`define GPIO_ADDRESS_PREFIX     8'h06
//`define USB_ADDRESS_PREFIX      8'h07
`define BOOTROM_ADDRESS_PREFIX  12'h1FC
`define LONGEST_ADDRESS_PREFIX_WIDTH 12



`define EVAL(A) `A
`define CONCAT_TO_LENGTH(NAME, LENGTH) {NAME, {(LENGTH - $bits(NAME)){1'b0}}}
`define SHIFT_TO_LENGTH(NAME,LENGTH) (NAME << (LENGTH-$bits(NAME)))
`define ADD_PREFIX(NAME) `SHIFT_TO_LENGTH(`EVAL(NAME``_ADDRESS_PREFIX), `LONGEST_ADDRESS_PREFIX_WIDTH)

`define BOOTROM_ADDRESS_WIDTH  12 // 16 KB
`define RAM_ADDRESS_WIDTH      21 // 8 MB
`define FLASH_ADDRESS_WIDTH    21 // 8 MB
`define UART_ADDRESS_WIDTH     1  // 2 address
`define VGA_ADDRESS_WIDTH      17
//`define TIMER_ADDRESS_WIDTH    1  // 1 address
//`define GRAPHICS_ADDRESS_WIDTH 17 // 512 KB, use 480004 Byte
//`define ETHERNET_ADDRESS_WIDTH 1  // 2 addresses
//`define GPIO_ADDRESS_WIDTH     2  // 3 addresses 
//`define USB_ADDRESS_WIDTH      1  // 2 addresses
typedef logic [`BOOTROM_ADDRESS_WIDTH - 1 : 0] BootRomAddress;

`define REGISTER_IRQ(MODULE, NAME, SOURCE) genvar i; \
generate \
    for (i = 0; i < $bits(Interrupt); i++) begin \
        assign SOURCE[i] = (i == `EVAL(IRQ_``MODULE)) ? NAME : 1'b0; \
    end \
endgenerate

interface Bus_if(
    input Clock_t clk
    );
    Word address;
    Bit_t read,write,stall;
    Word data_r1,data_r2,data_w;
    ByteMask mask;
    Interrupt interrupt;
    logic use_cpld_uart;
    
    modport master(
        output address,read,write,data_w,mask,
        input stall,data_r1,data_r2,interrupt,
        input clk,
        output use_cpld_uart
        );
    
    modport slave(
        output stall,data_r1,data_r2,interrupt,
        input address,read,write,data_w,mask,
        input clk,
        input use_cpld_uart
        );
        
endinterface

`define FLASH_CHIP_ADDRESS_WIDTH 23
typedef logic [`FLASH_CHIP_ADDRESS_WIDTH-1 : 0] FlashChipAddress;
`define FLASH_OP_READ 16'h00FF

interface Flash_if();
	FlashChipAddress address;
	wire HalfWord data;
	logic rp,vpen,ce,oe,we,byte_n;
	modport master(
		output address,rp,vpen,ce,oe,we,byte_n,
		inout data
	);
endinterface


interface UART_if();
    logic txd, rxd;
    modport master(
        output txd,
        input  rxd
    );
endinterface

`define SRAM_CHIP_ADDRESS_WIDTH 20
typedef logic [`SRAM_CHIP_ADDRESS_WIDTH-1 : 0] SramChipAddress;

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

interface VGA_if();
    logic[2:0] video_red,video_green;
    logic[1:0] video_blue;
    logic video_hsync,video_vsync,video_de;
    logic video_clk;
    modport master(
        output video_red,video_green,video_blue,video_hsync,video_vsync,video_de,video_clk
    );
endinterface

`endif
    