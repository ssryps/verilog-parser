`default_nettype none
 
module thinpad_top(
    input wire clk_50M,           //50MHz ʱ������
    input wire clk_11M0592,       //11.0592MHz ʱ������

    input wire clock_btn,         //BTN5�ֶ�ʱ�Ӱ�ť���أ���������·������ʱΪ1
    input wire reset_btn,         //BTN6�ֶ���λ��ť���أ���������·������ʱΪ1
	
    input  wire[3:0]  touch_btn,  //BTN1~BTN4����ť���أ�����ʱΪ1
    input  wire[31:0] dip_sw,     //32λ���뿪�أ�����"ON"ʱΪ1
    output wire[15:0] leds,       //16λLED�����ʱ1����
    output wire[7:0]  dpy0,       //����ܵ�λ�źţ�����С���㣬���1����
    output wire[7:0]  dpy1,       //����ܸ�λ�źţ�����С���㣬���1����

    //CPLD���ڿ������ź�
    output reg uart_rdn,         //�������źţ�����Ч
    output reg uart_wrn,         //д�����źţ�����Ч
    input wire uart_dataready,    //��������׼����
    input wire uart_tbre,         //�������ݱ�־
    input wire uart_tsre,         //���ݷ�����ϱ�־

    //BaseRAM�ź�
    inout wire[31:0] base_ram_data,  //BaseRAM���ݣ���8λ��CPLD���ڿ���������
    output reg[19:0] base_ram_addr, //BaseRAM��ַ
    output reg[3:0] base_ram_be_n,  //BaseRAM�ֽ�ʹ�ܣ�����Ч�������ʹ���ֽ�ʹ�ܣ��뱣��Ϊ0
    output reg base_ram_ce_n,       //BaseRAMƬѡ������Ч
    output reg base_ram_oe_n,       //BaseRAM��ʹ�ܣ�����Ч
    output reg base_ram_we_n,       //BaseRAMдʹ�ܣ�����Ч

    //ExtRAM�ź�
    inout wire[31:0] ext_ram_data,  //ExtRAM����
    output reg[19:0] ext_ram_addr, //ExtRAM��ַ
    output reg[3:0] ext_ram_be_n,  //ExtRAM�ֽ�ʹ�ܣ�����Ч�������ʹ���ֽ�ʹ�ܣ��뱣��Ϊ0
    output reg ext_ram_ce_n,       //ExtRAMƬѡ������Ч
    output reg ext_ram_oe_n,       //ExtRAM��ʹ�ܣ�����Ч
    output reg ext_ram_we_n,       //ExtRAMдʹ�ܣ�����Ч

    //ֱ�������ź�
    output wire txd,  //ֱ�����ڷ��Ͷ�
    input  wire rxd,  //ֱ�����ڽ��ն�

    //Flash�洢���źţ��ο� JS28F640 оƬ�ֲ�
    output wire [22:0]flash_a,      //Flash��ַ��a0����8bitģʽ��Ч��16bitģʽ������
    inout  wire [15:0]flash_d,      //Flash����
    output wire flash_rp_n,         //Flash��λ�źţ�����Ч
    output wire flash_vpen,         //Flashд�����źţ��͵�ƽʱ���ܲ�������д
    output wire flash_ce_n,         //FlashƬѡ�źţ�����Ч
    output wire flash_oe_n,         //Flash��ʹ���źţ�����Ч
    output wire flash_we_n,         //Flashдʹ���źţ�����Ч
    output wire flash_byte_n,       //Flash 8bitģʽѡ�񣬵���Ч����ʹ��flash��16λģʽʱ����Ϊ1

    //USB �������źţ��ο� SL811 оƬ�ֲ�
    output wire sl811_a0,
    //inout  wire[7:0] sl811_d,     //USB�������������������dm9k_sd[7:0]����
    output wire sl811_wr_n,
    output wire sl811_rd_n,
    output wire sl811_cs_n,
    output wire sl811_rst_n,
    output wire sl811_dack_n,
    input  wire sl811_intrq,
    input  wire sl811_drq_n,

    //����������źţ��ο� DM9000A оƬ�ֲ�
    output wire dm9k_cmd,
    inout  wire[15:0] dm9k_sd,
    output wire dm9k_iow_n,
    output wire dm9k_ior_n,
    output wire dm9k_cs_n,
    output wire dm9k_pwrst_n,
    input  wire dm9k_int,

    //ͼ������ź�
    output wire[2:0] video_red,    //��ɫ���أ�3λ
    output wire[2:0] video_green,  //��ɫ���أ�3λ
    output wire[1:0] video_blue,   //��ɫ���أ�2λ
    output wire video_hsync,       //��ͬ����ˮƽͬ�����ź�
    output wire video_vsync,       //��ͬ������ֱͬ�����ź�
    output wire video_clk,         //����ʱ�����
    output wire video_de           //��������Ч�źţ���������������
    
    
);

/* =========== Demo code begin =========== */

// PLL��Ƶʾ��
wire locked, clk_10M, clk_20M;
pll_example clock_gen 
 (
  // Clock out ports
  .clk_out1(clk_10M), // ʱ�����1��Ƶ����IP���ý���������
  .clk_out2(clk_20M), // ʱ�����2��Ƶ����IP���ý���������
  // Status and control signals
  .reset(reset_btn), // PLL��λ����
  .locked(locked), // ���������"1"��ʾʱ���ȶ�������Ϊ�󼶵�·��λ
 // Clock in ports
  .clk_in1(clk_50M) // �ⲿʱ������
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

// 7���������������ʾ����number��16������ʾ�����������

reg[7:0] number;
SEG7_LUT segL(.oSEG1(dpy0), .iDIG(number[3:0])); //dpy0�ǵ�λ�����
SEG7_LUT segH(.oSEG1(dpy1), .iDIG(number[7:4])); //dpy1�Ǹ�λ�����

reg[15:0] led_bits;
assign leds = led_bits;


// BaseRAM & ExtRAM ========================================================


reg[31:0] mips_instr_to_write;
wire[31:0] mips_pc;
wire mips_instr_ce;    // ȡָ ce

reg[31:0] mips_mem_data_to_write;
wire[31:0] mips_mem_addr;
wire mips_mem_ce;   // �ô� ce
wire mips_mem_we;   // �ô� we
wire[3:0] mips_mem_sel;  // �ô��ֽ�ѡ��

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

// ����߼� =====================================================

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
                    // д����
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

// ����״̬ ================================================

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

/* ================= BaseRAMʵ�� ===================== */
//parameter [2:0] ADDR   = 3'b000, 
//                DATA    = 3'b001,
//                WRITE   = 3'b010,
//                READ    = 3'b011;
//always@(posedge clock_btn or posedge reset_btn) begin
//    if(reset_btn)begin //��λ����
//        state <= ADDR;
//        bram_oe_n <= 1;
//        bram_we_n <= 1;
//        uart_read_n <= 1;
//		uart_write_n <= 1;
//        led_bits <= 16'b0;
//    end
//    else begin //����ʱ�Ӱ�ť
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



/* ================= ������ʵ�� ===================== */
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
//		        is_writing <= 0;  // base ram ����
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

/* ================= д����ʵ�� ===================== */

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

/* ============== �ڴ洮��ʵ�飬Final submission ================== */

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
