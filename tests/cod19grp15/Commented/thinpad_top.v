`default_nettype none
 
module thinpad_top(
    input wire clk_50M,           //50MHz 时钟输入
    input wire clk_11M0592,       //11.0592MHz 时钟输入

    input wire clock_btn,         //BTN5手动时钟按钮开关，带消抖电路，按下时为1
    input wire reset_btn,         //BTN6手动复位按钮开关，带消抖电路，按下时为1
	
    input  wire[3:0]  touch_btn,  //BTN1~BTN4，按钮开关，按下时为1
    input  wire[31:0] dip_sw,     //32位拨码开关，拨到"ON"时为1
    output wire[15:0] leds,       //16位LED，输出时1点亮
    output wire[7:0]  dpy0,       //数码管低位信号，包括小数点，输出1点亮
    output wire[7:0]  dpy1,       //数码管高位信号，包括小数点，输出1点亮

    //CPLD串口控制器信号
    output reg uart_rdn,         //读串口信号，低有效
    output reg uart_wrn,         //写串口信号，低有效
    input wire uart_dataready,    //串口数据准备好
    input wire uart_tbre,         //发送数据标志
    input wire uart_tsre,         //数据发送完毕标志

    //BaseRAM信号
    inout wire[31:0] base_ram_data,  //BaseRAM数据，低8位与CPLD串口控制器共享
    output reg[19:0] base_ram_addr, //BaseRAM地址
    output reg[3:0] base_ram_be_n,  //BaseRAM字节使能，低有效。如果不使用字节使能，请保持为0
    output reg base_ram_ce_n,       //BaseRAM片选，低有效
    output reg base_ram_oe_n,       //BaseRAM读使能，低有效
    output reg base_ram_we_n,       //BaseRAM写使能，低有效

    //ExtRAM信号
    inout wire[31:0] ext_ram_data,  //ExtRAM数据
    output reg[19:0] ext_ram_addr, //ExtRAM地址
    output reg[3:0] ext_ram_be_n,  //ExtRAM字节使能，低有效。如果不使用字节使能，请保持为0
    output reg ext_ram_ce_n,       //ExtRAM片选，低有效
    output reg ext_ram_oe_n,       //ExtRAM读使能，低有效
    output reg ext_ram_we_n,       //ExtRAM写使能，低有效

    //直连串口信号
    output wire txd,  //直连串口发送端
    input  wire rxd,  //直连串口接收端

    //Flash存储器信号，参考 JS28F640 芯片手册
    output wire [22:0]flash_a,      //Flash地址，a0仅在8bit模式有效，16bit模式无意义
    inout  wire [15:0]flash_d,      //Flash数据
    output wire flash_rp_n,         //Flash复位信号，低有效
    output wire flash_vpen,         //Flash写保护信号，低电平时不能擦除、烧写
    output wire flash_ce_n,         //Flash片选信号，低有效
    output wire flash_oe_n,         //Flash读使能信号，低有效
    output wire flash_we_n,         //Flash写使能信号，低有效
    output wire flash_byte_n,       //Flash 8bit模式选择，低有效。在使用flash的16位模式时请设为1

    //USB 控制器信号，参考 SL811 芯片手册
    output wire sl811_a0,
    //inout  wire[7:0] sl811_d,     //USB数据线与网络控制器的dm9k_sd[7:0]共享
    output wire sl811_wr_n,
    output wire sl811_rd_n,
    output wire sl811_cs_n,
    output wire sl811_rst_n,
    output wire sl811_dack_n,
    input  wire sl811_intrq,
    input  wire sl811_drq_n,

    //网络控制器信号，参考 DM9000A 芯片手册
    output wire dm9k_cmd,
    inout  wire[15:0] dm9k_sd,
    output wire dm9k_iow_n,
    output wire dm9k_ior_n,
    output wire dm9k_cs_n,
    output wire dm9k_pwrst_n,
    input  wire dm9k_int,

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

// PLL分频示例
wire locked, clk_10M, clk_20M;
pll_example clock_gen 
 (
  // Clock out ports
  .clk_out1(clk_10M), // 时钟输出1，频率在IP配置界面中设置
  .clk_out2(clk_20M), // 时钟输出2，频率在IP配置界面中设置
  // Status and control signals
  .reset(reset_btn), // PLL复位输入
  .locked(locked), // 锁定输出，"1"表示时钟稳定，可作为后级电路复位
 // Clock in ports
  .clk_in1(clk_50M) // 外部时钟输入
 );

reg reset_of_clk10M;

//always@(posedge clk_10M or negedge locked) begin
//    if(~locked) reset_of_clk10M <= 1'b1;
//    else        reset_of_clk10M <= 1'b0;
//end

//always@(posedge clk_10M or posedge reset_of_clk10M) begin
//    if(reset_of_clk10M)begin
//        // Your Code
//    end
//    else begin
//        // Your Code
//    end
//end

/* =========== Demo code end =========== */

//assign ext_ram_ce_n = 1'b1;
//assign ext_ram_oe_n = 1'b1;
//assign ext_ram_we_n = 1'b1;

//assign base_ram_be_n = 4'b0;
//assign base_ram_ce_n = 1'b0;

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


// BaseRAM & ExtRAM ========================================================


reg[31:0] mips_instr_to_write;
wire[31:0] mips_pc;
wire mips_instr_ce;    // 取指 ce

reg[31:0] mips_mem_data_to_write;
wire[31:0] mips_mem_addr;
wire mips_mem_ce;   // 访存 ce
wire mips_mem_we;   // 访存 we
wire[3:0] mips_mem_sel;  // 访存字节选择

wire[31:0] data_to_write;
// mips_mem_ce && mips_mem_we: chip enabled, writing
assign base_ram_data = (mips_mem_ce && mips_mem_we) ? data_to_write : 32'bz;
assign ext_ram_data = (mips_mem_ce && mips_mem_we) ? data_to_write : 32'bz;

wire[7:0] uart_data;
assign uart_data = base_ram_data[7:0];

reg uart_start_write;
reg uart_start_read;
reg uart_busy;

wire mips_mem_sram_ce;  // TODO
wire mips_mem_uart_ce;  // TODO

// Interrupt =========================================================
wire[5:0] interrupt_i;
wire timer_interrupt_o;

// MIPS CPU ===========================================================

mips mips0(
    .clk(clk_11M0592),
    .rst(reset_btn),
    
    .rom_data_i(mips_instr_to_write),  
    .rom_addr_o(mips_pc),
    .rom_ce_o(mips_instr_ce), 
    
    .ram_data_i(mips_mem_data_to_write),
    .ram_addr_o(mips_mem_addr),
    .ram_data_o(data_to_write),
    .ram_ce_o(mips_mem_ce),
    .ram_we_o(mips_mem_we),
    .ram_sel_o(mips_mem_sel),
    
    .int_i(interrupt_i),
    .timer_int_o(timer_interrupt_o),
    
//    .ctrl_uart_clear_pause_i(mips_uart_clear_pause),
    .mem_uart_busy_i(uart_busy),
    .mem_sram_ce_o(mips_mem_sram_ce),
    .mem_uart_ce_o(mips_mem_uart_ce)
);

// 组合逻辑 =====================================================

reg clear_read;
reg clear_write;
//reg mips_uart_clear_pause;

always@(*) begin
    if (reset_btn) begin
        mips_mem_data_to_write <= 32'b0;
        // Base RAM init
        base_ram_addr <= 20'b0;
        base_ram_be_n <= 4'b1111;
        base_ram_ce_n <= 1'b1;
        base_ram_oe_n <= 1'b1;
        base_ram_we_n <= 1'b1;
        // Ext RAM init
        ext_ram_addr <= 20'b0;
        ext_ram_be_n <= 4'b1111;
        ext_ram_ce_n <= 1'b1;
        ext_ram_oe_n <= 1'b1;
        ext_ram_we_n <= 1'b1;
        uart_start_write <= 1'b0;
        uart_start_read <= 1'b0;
    end
    else begin
        mips_mem_data_to_write <= 32'b0;
        // Base RAM init
        base_ram_addr <= 20'b0;
        base_ram_be_n <= 4'b1111;
        base_ram_ce_n <= 1'b1;
        base_ram_oe_n <= 1'b1;
        base_ram_we_n <= 1'b1;
        // Ext RAM init        
        ext_ram_addr <= 20'b0;
        ext_ram_be_n <= 4'b1111;
        ext_ram_ce_n <= 1'b1;
        ext_ram_oe_n <= 1'b1;
        ext_ram_we_n <= 1'b1;
        uart_start_write <= 1'b0;
        uart_start_read <= 1'b0;
//        mips_uart_clear_pause <= 1'b0;
        if (mips_mem_ce) begin  // data memory
          if (mips_mem_sram_ce == 1'b1) begin
            if (mips_mem_addr[22] == 1'b0) begin    // BaseRAM
                base_ram_addr <= mips_mem_addr[21:2];
                base_ram_ce_n <= 1'b0;
                base_ram_be_n <= ~mips_mem_sel;
                
                if (mips_mem_we) begin  // write enable
                    base_ram_we_n <= 1'b0;
                    base_ram_oe_n <= 1'b1;  // read disable
                end
                else begin  // read enable
                    base_ram_oe_n <= 1'b0;
                    base_ram_we_n <= 1'b1;  // write disable
                    mips_mem_data_to_write <= base_ram_data;
                end                
            end // end BaseRAM
            else begin // ExtRAM
                ext_ram_addr <= mips_mem_addr[21:2];
                ext_ram_ce_n <= 1'b0;
                ext_ram_be_n <= ~mips_mem_sel;
                
                if (mips_mem_we) begin  // write enable
                    ext_ram_we_n <= 1'b0;
                    ext_ram_oe_n <= 1'b1;  // read disable
                end
                else begin  // read enable
                    ext_ram_oe_n <= 1'b0;
                    ext_ram_we_n <= 1'b1;  // write disable
                    mips_mem_data_to_write <= ext_ram_data;
                end
            end // end ExtRAM
          end // end mips_mem_sram_ce
          else if (mips_mem_uart_ce == 1'b1) begin
            if (mips_mem_addr[3:0] == 4'hc) begin
                // TODO
                mips_mem_data_to_write <= { 30'b0, uart_dataready, ~uart_busy };
//                mips_uart_clear_pause <= 1'b1;
            end else begin
                if (mips_mem_we) begin  // write enable
                    // TODO
                    uart_start_write <= 1'b1;
                    // 写串口
                    if (clear_write == 1'b1)
                        uart_start_write <= 1'b0;
                        
                end else begin        // read enable
                    // TODO
                    uart_start_read <= 1'b1;
                    if (clear_read == 1'b1)
                        uart_start_read <= 1'b0;
                        
                        mips_mem_data_to_write <= { 24'b0, uart_data };
                    
                end
            end
          end // end mips_mem_uart_ce
        end // end DM
        else if (mips_instr_ce) begin  // instruction memory (read only from memory, write only to CPU)
//            $display("mips_instr_ce: %b", mips_pc);
            if (mips_pc[22] == 1'b0) begin   // BaseRAM
                base_ram_addr <= mips_pc[21:2];
                base_ram_ce_n <= 1'b0;
                base_ram_be_n <= 4'b0;
                
                base_ram_oe_n <= 1'b0;
                base_ram_we_n <= 1'b1;  // write disable
                mips_instr_to_write <= base_ram_data;
            end
            else begin  // ExtRAM
                ext_ram_addr <= mips_pc[21:2];
                ext_ram_ce_n <= 1'b0;
                ext_ram_be_n <= 4'b0;
                
                ext_ram_oe_n <= 1'b0;
                ext_ram_we_n <= 1'b1;  // write disable
                mips_instr_to_write <= ext_ram_data;
            end
        end // end IM
        else begin
//            $display("nothing is happening");
        end
    end
end

// 串口状态 ================================================

reg [2:0] uart_state;

parameter [2:0] START_READ = 3'b000,
                 READ_UART = 3'b010,
                 END_WRITE = 3'b100,
                 WAIT_TBRE = 3'b101,
                 WAIT_TSRE = 3'b110,
                 FINISH = 3'b111;


always @(posedge clk_11M0592) begin
    if (reset_btn) begin
        uart_rdn <= 1'b1;
        uart_wrn <= 1'b1;
        uart_busy <= 1'b0;   
        clear_write <= 1'b0;
        clear_read <= 1'b0;    
        uart_state <= FINISH; 
    end
    else begin
            case (uart_state)
                START_READ: begin
                    if (uart_dataready) begin
                        // enable mips_mem_data_to_write <= ...
                        uart_rdn <= 1'b0;    
                        uart_state <= READ_UART;
                    end
                end
                READ_UART: begin
                        clear_read <= 1'b1;
                        uart_rdn <= 1'b1;  
                        uart_busy <= 1'b0;
                        uart_state <= FINISH; 
                end
                END_WRITE: begin
                    // enable data_to_write <= ...
                    uart_wrn <= 1'b1;
                    uart_state <= WAIT_TBRE;
                end
                WAIT_TBRE: begin
                    if (uart_tbre) begin
                        uart_state <= WAIT_TSRE;
                    end
                end
                WAIT_TSRE: begin
                    if (uart_tsre) begin
                        clear_write <= 1'b1;
                        uart_busy <= 1'b0;
                        uart_state <= FINISH;
                    end
                end
                FINISH: begin
                    uart_rdn <= 1'b1;
                    uart_wrn <= 1'b1;
                    clear_write <= 1'b0;
                    clear_read <= 1'b0;
                    if (uart_start_write) begin
                        uart_busy <= 1'b1;
                        uart_state <= END_WRITE;
                        uart_wrn <= 1'b0;
                    end
                    else if (uart_start_read) begin
                        uart_busy <= 1'b1;
                        uart_state <= START_READ;
                   end
                end
            endcase
        end
end

/* ================= BaseRAM实验 ===================== */
//parameter [2:0] ADDR   = 3'b000, 
//                DATA    = 3'b001,
//                WRITE   = 3'b010,
//                READ    = 3'b011;
//always@(posedge clock_btn or posedge reset_btn) begin
//    if(reset_btn)begin //复位按下
//        state <= ADDR;
//        bram_oe_n <= 1;
//        bram_we_n <= 1;
//        uart_read_n <= 1;
//		uart_write_n <= 1;
//        led_bits <= 16'b0;
//    end
//    else begin //按下时钟按钮
//        case (state)
//            ADDR:   begin
//                        bram_addr <= dip_sw[19:0];
//                        led_bits <= 16'b0;
//                        base_ram_addr_end <= dip_sw[19:0] + 9;
//                        state <= DATA;
//                    end
//            DATA:   begin
//                        data_to_write <= dip_sw;
//                        led_bits <= 16'b0;
//                        bram_we_n <= 0;
//                        is_writing <= 1;
//                        state <= WRITE;
//                    end
//            WRITE:  begin
//                        if (base_ram_addr == base_ram_addr_end) begin
//                            led_bits[15:8] <= bram_addr[7:0];
//                            led_bits[7:0] <= data_to_write[7:0];
//                            bram_addr <= base_ram_addr_end - 9;
//                            bram_oe_n <= 0;
//                            bram_we_n <= 1;
//                            is_writing <= 0;
//                            state <= READ;
//                        end else begin
//                            bram_addr <= bram_addr + 1;
//                            data_to_write <= data_to_write + 1;
//                            led_bits[15:8] <= bram_addr[7:0];
//                            led_bits[7:0] <= data_to_write[7:0];
//                            is_writing <= 1;
//                        end
//                    end
//            READ:   begin
//                        if (base_ram_addr == base_ram_addr_end) begin
//                            bram_oe_n <= 1;
//                            bram_we_n <= 1;
//                            led_bits <= base_ram_data;
//                            state <= ADDR;
//                        end else begin
//                            bram_addr <= bram_addr + 1;
//                            led_bits <= base_ram_data;
//                        end
//                    end
//            default:    begin
//                        end
//        endcase
//    end
//end



/* ================= 读串口实验 ===================== */
//parameter [1:0]    READY = 2'b01,
//                    UART_READ = 2'b10,
//                    SHOW = 2'b11;
//always@(posedge clock_btn or posedge reset_btn) begin
//	if (reset_btn) begin
//	    number <= 8'b0;
//        led_bits <= 16'h0;
//		bram_oe_n <= 1;	// disable base ram read
//		bram_we_n <= 1;	// disable base ram write
//		uart_read_n <= 0;	// enable uart read
//		uart_write_n <= 1;	// disable uart write
//		is_writing <= 0;	// base ram not writing
//		bram_addr <= dip_sw[19:0];	// set address
//        state <= READY;
//	end
//	else begin
//		case(state)
//		    READY: begin
//		    	number <= { 6'b0, state };
//		        is_writing <= 0;  // base ram 高阻
//		        uart_read_n <= 0;
//		        state <= UART_READ;
//		    end
//			UART_READ: begin
//				number <= { 6'b0, state };			
//		        if (uart_dataready) begin
//					is_writing <= 1;
//					data_to_write <= {24'b0, uart_data};
//					bram_we_n <= 0;    // enable base ram write
//					uart_read_n <= 1;  // disable uart read
//					state <= SHOW;
//				end
//				else begin
//				    state <= READY;
//				end
//			end
//			SHOW: begin
//				number <= { 6'b0, state };
//			    is_writing <= 0;
//				bram_we_n <= 1;    // disable base ram write
//				uart_read_n <= 1;
//				led_bits <= base_ram_data;
//				state <= READY;
//			end
//		endcase
//	end
//end

/* ================= 写串口实验 ===================== */

//parameter [2:0] INIT = 3'b000,
//				WRITE_UART = 3'b001,
//				END_WRITE = 3'b010,
//				WAIT_TBRE = 3'b011,
//				WAIT_TSRE = 3'b100;

//always@(posedge clock_btn or posedge reset_btn) begin
//	if (reset_btn) begin
//		number <= 8'b0;
//		bram_oe_n <= 1;
//        bram_we_n <= 1;
//        uart_read_n <= 1;
//		uart_write_n <= 1;
//		is_writing <= 0;	// base ram not writing
//        bram_addr <= dip_sw[19:0];
//        state <= INIT;
//	end
//	else begin
//		case(state)
//			INIT: begin
//				number <= 8'b0;
//				data_to_write <= dip_sw;
//                bram_we_n <= 0;     // enable base ram write
//                is_writing <= 1;
//				data_to_write <= {24'b0, dip_sw[7:0]};
//				state <= WRITE_UART;
//			end
//			WRITE_UART: begin
//				number <= { 5'b0, state };
//				bram_oe_n <= 1; // disable base ram read
//				uart_write_n <= 0;  // enable uart write
//				state <= END_WRITE;
//			end
//			END_WRITE: begin
//				number <= { 5'b0, state };
//				is_writing <= 0;
//				uart_write_n <= 1;  // disable uart write
//				state <= WAIT_TBRE;
//			end
//			WAIT_TBRE: begin
//				number <= { 5'b0, state };
//				if (uart_tbre) begin
//					state <= WAIT_TSRE;
//				end
//			end
//			WAIT_TSRE: begin
//				number <= { 5'b0, state };
//				if (uart_tsre) begin
//					state <= INIT;
//				end
//			end
//		endcase // state
//	end
//end

/* ============== 内存串口实验，Final submission ================== */

//parameter [2:0] RECEIVE = 3'b000,
//                 NEXT_ADDR = 3'b001,
//                 WRITE_UART = 3'b010,
//                 END_WRITE = 3'b011,
//                 WAIT_TBRE = 3'b100,
//                 WAIT_TSRE = 3'b101,
//                 FINISH = 3'b110;

//always @(posedge clk_11M0592) begin
//	if (reset_btn) begin
//		state <= RECEIVE;
//		bram_oe_n <= 1;	// disable base ram read
//		bram_we_n <= 1;	// disable base ram write
//		uart_read_n <= 0;	// enable uart read
//		uart_write_n <= 1;	// disable uart write
//		is_writing <= 0;	// base ram 32'bz
//		bram_addr <= dip_sw[19:0];	// set address
//		base_ram_addr_end <= dip_sw[19:0] + 9;
//	end
//	else begin
//		case (state)
//			RECEIVE: begin
//				if (uart_dataready) begin
//					is_writing <= 1;
//					data_to_write <= {24'b0, uart_data};   // set base ram data
//					bram_we_n <= 0;    // enable base ram write
//					uart_read_n <= 1;  // disable uart read
//					state <= NEXT_ADDR;
//				end
//			end

//			NEXT_ADDR: begin
//				if (base_ram_addr == base_ram_addr_end) begin   // finish receiving 10
//					is_writing <= 0;
//					bram_addr <= base_ram_addr_end - 9;
//					bram_oe_n <= 0;    // enable base ram read
//                    bram_we_n <= 1;    // disable base ram write
//					state <= WRITE_UART;
//				end
//				else begin  // need to receive next
//				    is_writing <= 0;
//					bram_addr <= base_ram_addr + 1;
//					bram_we_n <= 1;    // disable base ram write
//					uart_read_n <= 0;  // enable uard read
//					state <= RECEIVE;

//				end
//			end

//            WRITE_UART: begin
//				is_writing <= 1;
//				data_to_write <= {24'b0, uart_data};    // set base ram
//				bram_oe_n <= 1; // disable base ram read
//				uart_write_n <= 0;  // enable uart write
//				state <= END_WRITE;
//			end

//            END_WRITE: begin
//				is_writing <= 0;
//				uart_write_n <= 1;  // disable uart write
//				state <= WAIT_TBRE;
//			end

//			WAIT_TBRE: begin
//				if (uart_tbre) begin
//					state <= WAIT_TSRE;
//				end
//			end

//			WAIT_TSRE: begin
//				if (uart_tsre) begin
//					if (base_ram_addr == base_ram_addr_end) begin  // finish sending back 10
//						state <= FINISH;
//					end
//					else begin // need to send back next
//						bram_addr <= bram_addr + 1;
//						bram_oe_n <= 0;   // enable base ram read
//						state <= WRITE_UART;
//					end
//				end
//			end

//			default: begin
//			end
//		endcase // state
//	end
//end

endmodule
