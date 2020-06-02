`default_nettype none

`include "constants.vh"
`include "defines.vh"

module thinpad_top(
    input wire clk_50M,           //50MHz 时钟输入
    input wire clk_11M0592,       //11.0592MHz 时钟输入

    input wire clock_btn,         //BTN5手动时钟按钮开关，带消抖电路，按下时为1
    input wire reset_btn,         //BTN6手动复位按钮开关，带消抖电路，按下时为1

    input  wire[3:0]  touch_btn,  //BTN1~BTN4，按钮开关，按下时为1
    input  wire[31:0] dip_sw,     //32位拨码开关，拨到“ON”时为1
    output wire[15:0] leds,       //16位LED，输出时1点亮
    output wire[7:0]  dpy0,       //数码管低位信号，包括小数点，输出1点亮
    output wire[7:0]  dpy1,       //数码管高位信号，包括小数点，输出1点亮

    //CPLD串口控制器信号
    output reg uart_rdn,          //读串口信号，低有效
    output reg uart_wrn,          //写串口信号，低有效
    input wire uart_dataready,    //串口数据准备好
    input wire uart_tbre,         //发送数据标志
    input wire uart_tsre,         //数据发送完毕标志

    //BaseRAM信号
    inout wire[31:0] base_ram_data, //BaseRAM数据，低8位与CPLD串口控制器共享
    output reg[19:0] base_ram_addr, //BaseRAM地址
    output reg[3:0] base_ram_be_n,  //BaseRAM字节使能，低有效。如果不使用字节使能，请保持为0
    output reg base_ram_ce_n,       //BaseRAM片选，低有效
    output reg base_ram_oe_n,       //BaseRAM读使能，低有效
    output reg base_ram_we_n,       //BaseRAM写使能，低有效

    //ExtRAM信号
    inout wire[31:0] ext_ram_data, //ExtRAM数据
    output reg[19:0] ext_ram_addr, //ExtRAM地址
    output reg[3:0] ext_ram_be_n,  //ExtRAM字节使能，低有效。如果不使用字节使能，请保持为0
    output reg ext_ram_ce_n,       //ExtRAM片选，低有效
    output reg ext_ram_oe_n,       //ExtRAM读使能，低有效
    output reg ext_ram_we_n,       //ExtRAM写使能，低有效

    //直连串口信号
    output wire txd,  //直连串口发送端
    input  wire rxd,  //直连串口接收端

    //Flash存储器信号，参考 JS28F640 芯片手册
    output reg [22:0]flash_a,      //Flash地址，a0仅在8bit模式有效，16bit模式无意义
    inout  wire [15:0]flash_d,     //Flash数据
    output reg flash_rp_n,         //Flash复位信号，低有效
    output reg flash_vpen,         //Flash写保护信号，低电平时不能擦除、烧写
    output reg flash_ce_n,         //Flash片选信号，低有效
    output reg flash_oe_n,         //Flash读使能信号，低有效
    output reg flash_we_n,         //Flash写使能信号，低有效
    output reg flash_byte_n,       //Flash 8bit模式选择，低有效。在使用flash的16位模式时请设为1

    //USB+SD 控制器信号，参考 CH376T 芯片手册
    output wire ch376t_sdi,
    output wire ch376t_sck,
    output wire ch376t_cs_n,
    output wire ch376t_rst,
    input  wire ch376t_int_n,
    input  wire ch376t_sdo,

    //网络交换机信号，参考 KSZ8795 芯片手册及 RGMII 规范
    input  wire [3:0] eth_rgmii_rd,
    input  wire eth_rgmii_rx_ctl,
    input  wire eth_rgmii_rxc,
    output wire [3:0] eth_rgmii_td,
    output wire eth_rgmii_tx_ctl,
    output wire eth_rgmii_txc,
    output wire eth_rst_n,
    input  wire eth_int_n,

    input  wire eth_spi_miso,
    output wire eth_spi_mosi,
    output wire eth_spi_sck,
    output wire eth_spi_ss_n,

    //图像输出信号
    output wire[2:0] video_red,    //红色像素，3位
    output wire[2:0] video_green,  //绿色像素，3位
    output wire[1:0] video_blue,   //蓝色像素，2位
    output wire video_hsync,       //行同步（水平同步）信号
    output wire video_vsync,       //场同步（垂直同步）信号
    output wire video_clk,         //像素时钟输出
    output wire video_de           //行数据有效信号，用于区分消隐区
);

/* =========== Demo code begin =========== */

// PLL
wire locked, clk_10M, clk_20M, clk_125M, clk_200M, clk_40M;
pll_example clock_gen 
 (
  // Clock out ports
  .clk_out1(clk_10M), // 时钟输出1，频率在IP配置界面中设置
  .clk_out2(clk_20M), // 时钟输出2，频率在IP配置界面中设置
  .clk_out3(clk_125M), // 时钟输出3，频率在IP配置界面中设置
  .clk_out4(clk_200M), // 时钟输出4，频率在IP配置界面中设置
  .clk_out5(clk_40M), // 时钟输出5，频率在IP配置界面中设置
  // Status and control signals
  .reset(reset_btn), // PLL复位输入
  .locked(locked), // 锁定输出，"1"表示时钟稳定，可作为后级电路复位
 // Clock in ports
  .clk_in1(clk_50M) // 外部时钟输入
 );

reg reset_of_clk10M;
// 异步复位，同步释放
always@(posedge clk_10M or negedge locked) begin
    if(~locked) reset_of_clk10M <= 1'b1;
    else        reset_of_clk10M <= 1'b0;
end

// 数码管连接关系示意图，dpy1同理
// p=dpy0[0] // ---a---
// c=dpy0[1] // |     |
// d=dpy0[2] // f     b
// e=dpy0[3] // |     |
// b=dpy0[4] // ---g---
// a=dpy0[5] // |     |
// f=dpy0[6] // e     c
// g=dpy0[7] // |     |
//           // ---d---  p

// 7段数码管译码器演示，将number用16进制显示在数码管上面
reg[7:0] number;
SEG7_LUT segL(.oSEG1(dpy0), .iDIG(number[3:0])); //dpy0是低位数码管
SEG7_LUT segH(.oSEG1(dpy1), .iDIG(number[7:4])); //dpy1是高位数码管

reg[15:0] led_bits;
assign leds = led_bits;

//图像输出演示，分辨率800x600@75Hz，像素时钟为50MHz
wire [11:0] hdata;
assign video_red = hdata < 266 ? 3'b111 : 0; //红色竖条
assign video_green = hdata < 532 && hdata >= 266 ? 3'b111 : 0; //绿色竖条
assign video_blue = hdata >= 532 ? 2'b11 : 0; //蓝色竖条
assign video_clk = clk_50M;
vga #(12, 800, 856, 976, 1040, 600, 637, 643, 666, 1, 1) vga800x600at75 (
    .clk(clk_50M), 
    .hdata(hdata), //横坐标
    .vdata(),      //纵坐标
    .hsync(video_hsync),
    .vsync(video_vsync),
    .data_enable(video_de)
);

/* =========== Demo code end =========== */

wire[5:0] int_i;
wire timer_int;
assign int_i = {timer_int, 2'b00, uart_data_to_cpu_ready^already_read, 2'b00}; //{3'b000, serial_read_status^already_read_status, 1'b0, timer_int};
reg already_read_status = 1'b0;

wire[31:0] openmips_if_addr_o;
reg[31:0] openmips_if_data_i;
wire openmips_if_ce_o;
wire openmips_if_sram_ce_o;
wire openmips_if_flash_ce_o;
wire openmips_if_serial_ce_o;
wire openmips_if_vga_ce_o;
wire openmips_if_rom_ce_o;
wire openmips_if_rram_ce_o;
wire openmips_mem_we_o;
wire[31:0] openmips_mem_addr_o;
wire[3:0] openmips_mem_sel_o;
wire[31:0] openmips_mem_data_o;
reg[31:0] openmips_mem_data_i;
wire openmips_mem_ce_o;
wire openmips_mem_sram_ce_o;
wire openmips_mem_flash_ce_o;
wire openmips_mem_serial_ce_o;
wire openmips_mem_vga_ce_o;
wire openmips_mem_rom_ce_o;
wire openmips_mem_rram_ce_o;
wire[31:0] openmips_reg4;
wire[31:0] openmips_reg19;

openmips openmips0(
    .clk(clk_40M), // 40MHz
    .rst(reset_btn|~locked),
    .if_addr_o(openmips_if_addr_o),
    .if_data_i(openmips_if_data_i),
    .if_ce_o(openmips_if_ce_o),
    .if_sram_ce_o(openmips_if_sram_ce_o),
    .if_flash_ce_o(openmips_if_flash_ce_o),
    .if_serial_ce_o(openmips_if_serial_ce_o),
    .if_vga_ce_o(openmips_if_vga_ce_o),
    .if_rom_ce_o(openmips_if_rom_ce_o),
    .if_rram_ce_o(openmips_if_rram_ce_o),
    .mem_we_o(openmips_mem_we_o),
    .mem_addr_o(openmips_mem_addr_o),
    .mem_sel_o(openmips_mem_sel_o),
    .mem_data_o(openmips_mem_data_o),
    .mem_data_i(openmips_mem_data_i),
    .mem_ce_o(openmips_mem_ce_o),
    .mem_sram_ce_o(openmips_mem_sram_ce_o),
    .mem_flash_ce_o(openmips_mem_flash_ce_o),
    .mem_serial_ce_o(openmips_mem_serial_ce_o),
    .mem_vga_ce_o(openmips_mem_vga_ce_o),
    .mem_rom_ce_o(openmips_mem_rom_ce_o),
    .mem_rram_ce_o(openmips_mem_rram_ce_o),
    .int_i(int_i),
    .timer_int_o(timer_int),
    .reg4(openmips_reg4),
    .reg19(openmips_reg19),
    .externel_mem_stall(uart_stall_mem)
);

logic rram_w_en;
logic [3:0] rram_w_sel;
logic [`RRAM_ADDR_WIDTH-1:0] rram_w_addr;
logic [31:0] rram_w_data;

logic rram_r_en;
logic [3:0] rram_r_sel;
logic [`RRAM_ADDR_WIDTH-1:0] rram_r_addr;
logic [31:0] rram_r_data;

router_top routertop0(
    .clk_40M(clk_40M),
    .clk_50M(clk_50M),
    .clk_125M(clk_125M),
    .clk_200M(clk_200M),
    .locked(locked),
    .reset_btn(reset_btn),

    .eth_rgmii_rd(eth_rgmii_rd),
    .eth_rgmii_rx_ctl(eth_rgmii_rx_ctl),
    .eth_rgmii_rxc(eth_rgmii_rxc),
    .eth_rgmii_td(eth_rgmii_td),
    .eth_rgmii_tx_ctl(eth_rgmii_tx_ctl),
    .eth_rgmii_txc(eth_rgmii_txc),
    .eth_rst_n(eth_rst_n),

    .eth_int_n(eth_int_n),
    .eth_spi_miso(eth_spi_miso),
    .eth_spi_mosi(eth_spi_mosi),
    .eth_spi_sck(eth_spi_sck),
    .eth_spi_ss_n(eth_spi_ss_n),

    .rram_w_en(rram_w_en),
    .rram_w_sel(rram_w_sel),
    .rram_w_addr(rram_w_addr),
    .rram_w_data(rram_w_data),

    .rram_r_en(rram_r_en),
    .rram_r_sel(rram_r_sel),
    .rram_r_addr(rram_r_addr),
    .rram_r_data(rram_r_data)
);

reg uart_stall_mem;
reg[4:0] uart_state;
reg uart_data_to_cpu_ready;
reg[31:0] uart_data_to_cpu;
wire uart_data_can_read,uart_data_can_send;
reg uart_data_out_ready,uart_store_finish;
reg serial_output_enable;
reg[31:0] serial_output_data;
reg already_read,serial_send_status,previous_send_status;
assign base_ram_data = serial_output_enable?serial_output_data:((openmips_mem_ce_o && openmips_mem_sram_ce_o && openmips_mem_we_o)? openmips_mem_data_o: 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz); 
assign ext_ram_data = (openmips_mem_ce_o && openmips_mem_sram_ce_o && openmips_mem_we_o)? openmips_mem_data_o: 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz; // To drive the inout net

always @(*) begin
    if (reset_btn|~locked) begin
        base_ram_addr <= 20'b0;
        base_ram_be_n <= 4'b1111;
        base_ram_ce_n <= 1'b1;
        base_ram_oe_n <= 1'b1;
        base_ram_we_n <= 1'b1;
        ext_ram_addr <= 20'b0;
        ext_ram_be_n <= 4'b1111;
        ext_ram_ce_n <= 1'b1;
        ext_ram_oe_n <= 1'b1;
        ext_ram_we_n <= 1'b1;
        flash_a <= 23'b0;
        flash_rp_n <= 1'b1;
        flash_oe_n <= 1'b1;
        flash_ce_n <= 1'b1;
        flash_byte_n <= 1'b1;
        flash_we_n <= 1'b1;
        rram_w_en <= 1'b0;
        rram_w_sel <= 4'b0000;
        rram_r_en <= 1'b0;
        rram_r_sel <= 4'b0000;
        openmips_if_data_i <= 32'b0;
        openmips_mem_data_i <= 32'b0;
        serial_send_status<=1'b0;
        already_read<=0;
    end else begin
        base_ram_addr <= 20'b0;
        base_ram_be_n <= 4'b1111;
        base_ram_ce_n <= 1'b1;
        base_ram_oe_n <= 1'b1;
        base_ram_we_n <= 1'b1;
        ext_ram_addr <= 20'b0;
        ext_ram_be_n <= 4'b1111;
        ext_ram_ce_n <= 1'b1;
        ext_ram_oe_n <= 1'b1;
        ext_ram_we_n <= 1'b1;            
        flash_a <= 23'b0;
        flash_rp_n <= 1'b1;
        flash_oe_n <= 1'b1;
        flash_ce_n <= 1'b1;
        flash_byte_n <= 1'b1;
        flash_we_n <= 1'b1;
        rram_w_en <= 1'b0;
        rram_w_sel <= 4'b0000;
        rram_r_en <= 1'b0;
        rram_r_sel <= 4'b0000;
        openmips_if_data_i <= 32'b0;
        openmips_mem_data_i <= 32'b0;
        uart_stall_mem<=0;
        if(uart_state!=0) begin
            uart_stall_mem<=1;
        end else if (openmips_mem_ce_o) begin
            if (openmips_mem_sram_ce_o) begin
                if (openmips_mem_addr_o[22] == 1'b0) begin
                    base_ram_addr <= openmips_mem_addr_o[21:2];
                    base_ram_be_n <= ~openmips_mem_sel_o;
                    base_ram_ce_n <= 1'b0;
                    if (openmips_mem_we_o) begin
                        base_ram_oe_n <= 1'b1;
                        base_ram_we_n <= 1'b0;
                    end else begin
                        base_ram_oe_n <= 1'b0;
                        base_ram_we_n <= 1'b1;
                        openmips_mem_data_i <= base_ram_data;
                    end
                end else if (openmips_mem_addr_o[22] == 1'b1) begin
                    ext_ram_addr <= openmips_mem_addr_o[21:2];
                    ext_ram_be_n <= ~openmips_mem_sel_o;
                    ext_ram_ce_n <= 1'b0;
                    if (openmips_mem_we_o) begin
                        ext_ram_oe_n <= 1'b1;
                        ext_ram_we_n <= 1'b0;
                    end else begin
                        ext_ram_oe_n <= 1'b0;
                        ext_ram_we_n <= 1'b1;
                        openmips_mem_data_i <= ext_ram_data;
                    end
                end
            end else if (openmips_mem_flash_ce_o) begin
                flash_a <= openmips_mem_addr_o[23:1];
                flash_rp_n <= 1'b1;
                flash_oe_n <= 1'b0;
                flash_ce_n <= 1'b0;
                flash_byte_n <= 1'b1;
                flash_we_n <= 1'b1;
                openmips_mem_data_i <= { 16'b0, flash_d };
            end else if (openmips_mem_serial_ce_o) begin
                if (openmips_mem_addr_o[3:0] == 4'hc) begin
                    openmips_mem_data_i <= {30'b0, uart_data_to_cpu_ready^already_read, uart_tsre}; // <TODO>
                end else if (openmips_mem_addr_o[3:0] == 4'h8) begin
                    if (openmips_mem_we_o) begin
                        serial_send_status<=previous_send_status;
                        serial_output_data<={24'bz,openmips_mem_data_o[7:0]};
                    end else begin 
                        already_read<=uart_data_to_cpu_ready;
                        openmips_mem_data_i<=uart_data_to_cpu;
                    end
                end
            end else if (openmips_mem_vga_ce_o) begin
            end else if (openmips_mem_rom_ce_o) begin
            end else if (openmips_mem_rram_ce_o) begin
                if (openmips_mem_we_o) begin
                    rram_w_en <= 1'b1;
                    rram_w_sel <= openmips_mem_sel_o;
                    rram_w_addr <= openmips_mem_addr_o[`RRAM_ADDR_WIDTH-1:0];
                    rram_w_data <= openmips_mem_data_o;
                end else begin
                    rram_r_en <= 1'b1;
                    rram_r_sel <= openmips_mem_sel_o;
                    rram_r_addr <= openmips_mem_addr_o[`RRAM_ADDR_WIDTH-1:0];
                    openmips_mem_data_i <= rram_r_data;
                end
            end
        end else if (openmips_if_ce_o) begin
            if (openmips_if_sram_ce_o) begin
                if (openmips_if_addr_o[22] == 1'b0) begin
                    base_ram_addr <= openmips_if_addr_o[21:2];
                    base_ram_be_n <= 4'b0000;
                    base_ram_ce_n <= 1'b0;
                    base_ram_oe_n <= 1'b0;
                    base_ram_we_n <= 1'b1;
                    openmips_if_data_i <= base_ram_data;
                end else if (openmips_if_addr_o[22] == 1'b1) begin
                    ext_ram_addr <= openmips_if_addr_o[21:2];
                    ext_ram_be_n <= 4'b0000;
                    ext_ram_ce_n <= 1'b0;
                    ext_ram_oe_n <= 1'b0;
                    ext_ram_we_n <= 1'b1;
                    openmips_if_data_i <= ext_ram_data;
                end
            end else if (openmips_if_flash_ce_o) begin
                flash_a <= openmips_if_addr_o[23:1];
                flash_rp_n <= 1'b1;
                flash_oe_n <= 1'b0;
                flash_ce_n <= 1'b0;
                flash_byte_n <= 1'b1;
                flash_we_n <= 1'b1;
                openmips_if_data_i <= { 16'b0, flash_d };
            end else if (openmips_if_serial_ce_o) begin
                if (openmips_if_addr_o[3:0] == 4'hc) begin
                    openmips_if_data_i <= { 30'b0, uart_data_to_cpu_ready, uart_tsre}; // <TODO>
                end else if (openmips_if_addr_o[3:0] == 4'h8) begin
                    already_read<=uart_data_to_cpu_ready;
                    openmips_mem_data_i<=uart_data_to_cpu;
                end
            end else if (openmips_if_rom_ce_o) begin
            end
        end
    end
end

always @(posedge clk_40M) begin
    if (reset_btn|~locked) begin
        uart_wrn <= 1'b1;
        uart_rdn <= 1'b1;
        uart_state <= 3'b0;
        uart_data_to_cpu <= 32'b0;
        uart_data_to_cpu_ready<=0;
        previous_send_status<=1'b1;
        number <= 8'b0; 
    end else begin
        serial_output_enable<=1'b0;
        uart_wrn <= 1'b1;
        uart_rdn <= 1'b1;
        case(uart_state)
            0:begin 
                if(previous_send_status==serial_send_status)
                    uart_state<=1;
                else if(uart_dataready&&uart_data_to_cpu_ready==already_read) begin
                    uart_state<=5;
                end
            end
            1:begin//write
                serial_output_enable<=1;
                uart_state<=2;
            end
            2:begin//write
                serial_output_enable<=1;
                uart_wrn<=0;
                uart_state<=3;
            end
            3:begin//write
                serial_output_enable<=1;
                uart_wrn<=1;
                uart_state<=4;
            end
            4:begin//write
                if(uart_tbre) begin
                    uart_state<=0;
                    previous_send_status<=!previous_send_status;
                end
            end
            5:begin//read from uart
                if(uart_dataready)
                    uart_state<=6;
            end
            6:begin//read from uart
                uart_rdn<=0;
                uart_state<=7;
            end
            7:begin//read from uart
                uart_data_to_cpu<={24'b0,base_ram_data[7:0]};
                uart_data_to_cpu_ready<=!uart_data_to_cpu_ready;
                uart_state<=0;
            end
            default:begin
            end
        endcase
        number <= uart_data_to_cpu[7:0];
    end
end
endmodule
