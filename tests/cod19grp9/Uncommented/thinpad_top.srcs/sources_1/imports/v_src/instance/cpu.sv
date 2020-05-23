`include "../macro.v"
`include "../pc/pc_reg.v"
`include "../ex/ex.v"
`include "../mem/ex_mem.v"
`include "../id/id.v"
`include "../ex/id_ex.v"
`include "../id/if_id.v"
`include "../mem/mem.v"
`include "../wb/mem_wb.v"
`include "../id/regfile.sv"
`include "../wb/hilo_reg.v"
`include "../ctrl.v"
`include "../cp0/cp0_reg.sv"
`include "../except.sv"
module cpu(
/*
    input wire clk,rst,
    input wire[`RegBus] rom_data_i,
    input wire[`RegBus] ram_data_i,
    output wire[`RegBus] rom_addr_o,
    output wire rom_ce_o,
    output wire[`RegBus] ram_addr_o,
    output wire[`RegBus] ram_data_o,
    output wire ram_ce_o,
    output wire[3:0] ram_sel_o,
    output wire ram_write_enable_o,
    */
    Bus_if.master data_bus,
    Bus_if.master inst_bus,
    output wire reg_write_enable,
    output wire[`RegAddrBus] reg_write_addr,
    output wire[`RegBus] reg_write_data,
    output wire hilo_write_enable,
    output wire[63:0] hilo_data

    );

wire clk,rst;
wire[`RegBus] ex_addr_test,mem_addr_test;

wire[`RegBus] rom_data_i;
wire[`RegBus] ram_data_i;
wire[`RegBus] rom_addr_o;
wire rom_ce_o;
wire[`RegBus] ram_addr_o;
wire[`RegBus] ram_data_o;
wire ram_ce_o;
wire[3:0] ram_sel_o;
wire ram_write_enable_o;

assign clk = data_bus.clk.base;
assign rst = data_bus.clk.rst;
assign data_bus.address = ram_addr_o;
assign data_bus.data_w = ram_data_o;
assign data_bus.mask = ram_sel_o;
assign data_bus.write = ram_write_enable_o;
assign data_bus.read = ram_ce_o & ~ram_write_enable_o;
assign ram_data_i = data_bus.data_r1;
assign inst_bus.address = rom_addr_o;
assign inst_bus.write = 1'b0;
assign inst_bus.read = rom_ce_o;
assign rom_data_i = inst_bus.data_r1;

wire mem_is_load;
wire mem_is_save;
wire[`InstAddrBus] pc;
wire[`InstAddrBus] id_pc_i;
wire[`InstBus] id_inst_i;

wire[`AluOpBus] id_aluop_o;
wire[`AluSelBus] id_alusel_o;
wire[`RegBus] id_reg1_o,id_reg2_o;
wire id_wreg_o;
wire[`RegAddrBus] id_wd_o;

wire[`AluOpBus] ex_aluop_i;
wire[`AluSelBus] ex_alusel_i;
wire[`RegBus] ex_reg1_i,ex_reg2_i;
wire ex_wreg_i;
wire[`RegAddrBus] ex_wd_i;

wire ex_wreg_o;
wire[`RegAddrBus] ex_wd_o;
wire[`RegBus] ex_wdata_o;

wire mem_wreg_i;
wire[`RegAddrBus] mem_wd_i;
wire[`RegBus] mem_wdata_i;

wire mem_wreg_o;
wire[`RegAddrBus] mem_wd_o;
wire[`RegBus] mem_wdata_o;

wire wb_wreg_i;
wire[`RegAddrBus] wb_wd_i;
wire[`RegBus] wb_wdata_i;

wire reg1_read,reg2_read;
wire[`RegBus] reg1_data,reg2_data;
wire[`RegAddrBus] reg1_addr,reg2_addr;

wire[`RegBus] hi_i,lo_i,wb_hi_i,wb_lo_i;
wire wb_whilo_i;
wire[`RegBus] mem_hi_i,mem_lo_i;
wire mem_whilo_i;
wire[`RegBus] hi_o,lo_o;
wire whilo_o;

wire[`RegBus] mem1_hi,mem1_lo;
wire mem1_whilo;

wire stallreq_id,stallreq_ex;
wire[5:0] stall_temp;

wire brflag;
wire[`RegBus] braddr;

wire id_in_delayslot,ex_in_delayslot;
wire[`RegBus] id_link_addr,ex_link_addr;
wire in_delayslot,in_delayslot_next;

wire[`RegBus] id_inst,ex_inst;

wire[`AluOpBus] ex_aluop,mem_aluop;
wire[`RegBus] ex_mem_addr,mem_mem_addr;
wire[`RegBus] ex_reg2,mem_reg2;

//exception
wire flush;
wire[`RegBus] new_pc;

//wire[`RegBus] cp0_count;
//wire[`RegBus] cp0_compare;
//wire[`RegBus] cp0_status;
//wire[`RegBus] cp0_cause;
//wire[`RegBus] cp0_epc;
//wire[`RegBus] cp0_config;
//wire[`RegBus] cp0_prid; 

wire[`RegBus] latest_epc;

wire[14:0] if_except_info_o;

wire[14:0] id_except_info_i;

wire[14:0] id_except_info_o;
wire[`RegBus] id_inst_addr_current;

wire[14:0] ex_except_info_i;
wire[`RegBus] ex_inst_addr_current_i;

wire[14:0] ex_except_info_o;
wire[`RegBus] ex_inst_addr_current_o;
wire ex_in_delayslot_o;
wire ex_cp0_reg_we_o;
wire[4:0] ex_cp0_reg_write_addr_o;
wire[`RegBus] ex_cp0_reg_data_o; 

wire[14:0] mem_except_info_i;
wire mem_in_delayslot_i;
wire[`RegBus] mem_inst_addr_current_i;
wire mem_cp0_reg_we_i;
wire[4:0] mem_cp0_reg_write_addr_i;
wire[`RegBus] mem_cp0_reg_data_i;

wire[14:0] mem_except_info_o;
wire mem_in_delayslot_o;
wire[`RegBus] mem_inst_addr_current_o;
wire mem_cp0_reg_we_o;
wire[4:0] mem_cp0_reg_write_addr_o;
wire[`RegBus] mem_cp0_reg_data_o;	

wire wb_cp0_reg_we_i;
wire[4:0] wb_cp0_reg_write_addr_i;
wire[`RegBus] wb_cp0_reg_data_i;		
wire[14:0] wb_except_info_i;
wire wb_in_delayslot_i;
wire[`RegBus] wb_inst_addr_current_i;

wire[4:0] cp0_reg_read_addr;
wire[`RegBus] cp0_reg_read_data;

wire mem_we_and_ce;
wire ram_write_enable_before_except_o;

assign ram_write_enable_o = ram_write_enable_before_except_o & (~(|mem_except_info_o));

assign hilo_write_enable = wb_whilo_i;
assign hilo_data = {wb_hi_i, wb_lo_i};

assign reg_write_enable = wb_wreg_i;
assign reg_write_addr = wb_wd_i;
assign reg_write_data = wb_wdata_i;


//pc_reg instance
pc_reg pc_reg0(.clk(clk), .rst(rst), .stall(stall_temp), .brflag_i(brflag), .braddr_i(braddr), .flush(flush), .new_pc(new_pc), .pc(pc), .ce(rom_ce_o), .except_info(if_except_info_o));
assign rom_addr_o = pc;
//IF_ID instance
if_id if_id0(.clk(clk), .rst(rst), .if_pc(pc), .flush(flush), .if_inst(rom_data_i), .stall(stall_temp),
		.id_pc(id_pc_i), .id_inst(id_inst_i),
		.if_except_info(if_except_info_o), .id_except_info(id_except_info_i));
//ID instance
id id0(
.rst(rst), .pc_i(id_pc_i), .inst_i(id_inst_i),
       .reg1_data_i(reg1_data), .reg2_data_i(reg2_data),
       .ex_wreg_i(ex_wreg_o), .mem_wreg_i(mem_wreg_o),
       .ex_wdata_i(ex_wdata_o), .mem_wdata_i(mem_wdata_o),
       .ex_wd_i(ex_wd_o), .mem_wd_i(mem_wd_o), .in_delayslot_i(in_delayslot), 
       .ex_aluop_i(ex_aluop),
       .except_info_i(id_except_info_i),
       .reg1_read_o(reg1_read), .reg2_read_o(reg2_read),
       .reg1_addr_o(reg1_addr), .reg2_addr_o(reg2_addr),
       .aluop_o(id_aluop_o), .alusel_o(id_alusel_o),
       .reg1_o(id_reg1_o), .reg2_o(id_reg2_o),
       .wd_o(id_wd_o), .wreg_o(id_wreg_o), .stallreq(stallreq_id), .in_delayslot_next_o(in_delayslot_next),
       .brflag_o(brflag), .braddr_o(braddr), .link_addr_o(id_link_addr), .in_delayslot_o(id_in_delayslot),
       .inst_o(id_inst),
       .except_info_o(id_except_info_o), .inst_addr_current_o(id_inst_addr_current) 
       );
 //regfile instance
 
 regfile regfile0(.clk(clk), .rst(rst), .write_enable(wb_wreg_i), .write_addr(wb_wd_i), 
                  .write_data(wb_wdata_i), .read_enable_1(reg1_read), .read_addr_1(reg1_addr), 
                  .read_data_1(reg1_data), .read_enable_2(reg2_read), .read_addr_2(reg2_addr), 
                  .read_data_2(reg2_data));
 //ID/EX instance
 id_ex id_ex0(.clk(clk), .rst(rst), .flush(flush), .id_aluop(id_aluop_o), .id_alusel(id_alusel_o), .id_reg1(id_reg1_o),
  .id_reg2(id_reg2_o), 
 .id_wd(id_wd_o), .id_wreg(id_wreg_o), .stall(stall_temp), 
 .id_link_addr(id_link_addr), .id_in_delayslot(id_in_delayslot), .in_delayslot_next_i(in_delayslot_next), 
 .id_inst(id_inst), 
 .id_except_info(id_except_info_o), .id_inst_addr_current(id_inst_addr_current),
 .ex_aluop(ex_aluop_i), .ex_alusel(ex_alusel_i), .ex_reg1(ex_reg1_i),
  .ex_reg2(ex_reg2_i), 
 .ex_wd(ex_wd_i), .ex_wreg(ex_wreg_i), 
 .ex_link_addr(ex_link_addr), .ex_in_delayslot(ex_in_delayslot), .in_delayslot_o(in_delayslot), .ex_inst(ex_inst),
 .ex_except_info(ex_except_info_i), .ex_inst_addr_current(ex_inst_addr_current_i));
 
//EX instance
ex ex0(.rst(rst), .aluop_i(ex_aluop_i), .alusel_i(ex_alusel_i), .reg1_i(ex_reg1_i), .reg2_i(ex_reg2_i), 
.wd_i(ex_wd_i), .wreg_i(ex_wreg_i), 
.hi_i(hi_i), .lo_i(lo_i), .wb_hi_i(wb_hi_i), .wb_lo_i(wb_lo_i), .wb_whilo_i(wb_whilo_i),
.mem_hi_i(mem_hi_i), .mem_lo_i(mem_lo_i), .mem_whilo_i(mem_whilo_i), 
.link_addr_i(ex_link_addr), .in_delayslot_i(ex_in_delayslot),
.inst_i(ex_inst),  
.except_info_i(ex_except_info_i), .inst_addr_current_i(ex_inst_addr_current_i),
.mem_cp0_reg_we(mem_cp0_reg_we_o), .mem_cp0_reg_write_addr(mem_cp0_reg_write_addr_o), .mem_cp0_reg_data(mem_cp0_reg_data_o),
.wb_cp0_reg_we(wb_cp0_reg_we_i), .wb_cp0_reg_write_addr(wb_cp0_reg_write_addr_i), .wb_cp0_reg_data(wb_cp0_reg_data_i),
.cp0_reg_data_i(cp0_reg_read_data), .cp0_reg_read_addr_o(cp0_reg_read_addr),
.cp0_reg_we_o(ex_cp0_reg_we_o), .cp0_reg_write_addr_o(ex_cp0_reg_write_addr_o), .cp0_reg_data_o(ex_cp0_reg_data_o),	
.hi_o(hi_o), .lo_o(lo_o), .whilo_o(whilo_o), 
.mem_addr_test_o(ex_addr_test),

.wd_o(ex_wd_o), .wreg_o(ex_wreg_o), .write_data_o(ex_wdata_o), .stallreq(stallreq_ex), 
.aluop_o(ex_aluop), .mem_addr_o(ex_mem_addr), .reg2_o(ex_reg2),
.except_info_o(ex_except_info_o), .in_delayslot_o(ex_in_delayslot_o), .inst_addr_current_o(ex_inst_addr_current_o));
//EX/MEM instance
ex_mem ex_mem0(.clk(clk), .rst(rst), .flush(flush), .ex_wd(ex_wd_o), .ex_wreg(ex_wreg_o), .ex_wdata(ex_wdata_o), 
.ex_hi(hi_o), .ex_lo(lo_o), .ex_whilo(whilo_o),  .stall(stall_temp), 
.ex_addr_test_o(ex_addr_test),

.ex_aluop(ex_aluop), .ex_mem_addr(ex_mem_addr), .ex_reg2(ex_reg2), 
.mem_wd(mem_wd_i), .mem_wreg(mem_wreg_i), .mem_wdata(mem_wdata_i),
.ex_cp0_reg_we(ex_cp0_reg_we_o), .ex_cp0_reg_write_addr(ex_cp0_reg_write_addr_o), .ex_cp0_reg_data(ex_cp0_reg_data_o),
.ex_except_info(ex_except_info_o), .ex_in_delayslot(ex_in_delayslot_o), .ex_inst_addr_current(ex_inst_addr_current_o),		
.mem_hi(mem1_hi), .mem_lo(mem1_lo), .mem_whilo(mem1_whilo),
.mem_addr_test_o(mem_addr_test),


.mem_aluop(mem_aluop), .mem_mem_addr(mem_mem_addr), .mem_reg2(mem_reg2),
.mem_cp0_reg_we(mem_cp0_reg_we_i), .mem_cp0_reg_write_addr(mem_cp0_reg_write_addr_i), .mem_cp0_reg_data(mem_cp0_reg_data_i),
.mem_except_info(mem_except_info_i), .mem_in_delayslot(mem_in_delayslot_i), .mem_inst_addr_current(mem_inst_addr_current_i)
);
//MEM instance
mem mem0(.rst(rst), .wd_i(mem_wd_i), .wreg_i(mem_wreg_i), .wdata_i(mem_wdata_i),
.hi_i(mem1_hi), .lo_i(mem1_lo), .whilo_i(mem1_whilo), 
.mem_addr_test_i(mem_addr_test),

.aluop_i(mem_aluop), .mem_addr_i(mem_mem_addr), .reg2_i(mem_reg2), .mem_data_i(ram_data_i), 
.cp0_reg_we_i(mem_cp0_reg_we_i), .cp0_reg_write_addr_i(mem_cp0_reg_write_addr_i), .cp0_reg_data_i(mem_cp0_reg_data_i),
.except_info_i(mem_except_info_i), .in_delayslot_i(mem_in_delayslot_i), .inst_addr_current_i(mem_inst_addr_current_i),
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.cp0_reg_read_addr(cp0_reg_read_addr), .cp0_reg_read_data(cp0_reg_read_data), 
.wd_o(mem_wd_o), .wreg_o(mem_wreg_o), .wdata_o(mem_wdata_o),
.hi_o(mem_hi_i), .lo_o(mem_lo_i), .whilo_o(mem_whilo_i),
.mem_addr_o(ram_addr_o), .mem_write_enable_o(ram_write_enable_before_except_o), .mem_sel_o(ram_sel_o), 
.mem_data_o(ram_data_o), .mem_ce_o(ram_ce_o),
.wb_cp0_reg_we(wb_cp0_reg_we_i), .wb_cp0_reg_write_addr(wb_cp0_reg_write_addr_i), .wb_cp0_reg_data(wb_cp0_reg_data_i),
.cp0_reg_we_o(mem_cp0_reg_we_o), .cp0_reg_write_addr_o(mem_cp0_reg_write_addr_o), .cp0_reg_data_o(mem_cp0_reg_data_o),
.except_info_o(mem_except_info_o), .cp0_epc_o(latest_epc), .in_delayslot_o(mem_in_delayslot_o), .inst_addr_current_o(mem_inst_addr_current_o),	
 .is_load_o(mem_is_load), .mem_we_o(mem_is_save));
//MEM/WB instance
mem_wb mem_wb0(.clk(clk), .rst(rst), .flush(flush), .mem_wd(mem_wd_o), .mem_wreg(mem_wreg_o), .mem_wdata(mem_wdata_o), 
.mem_hi(mem_hi_i), .mem_lo(mem_lo_i), .mem_whilo(mem_whilo_i),  .stall(stall_temp), 
.mem_cp0_reg_we(mem_cp0_reg_we_o), .mem_cp0_reg_write_addr(mem_cp0_reg_write_addr_o), .mem_cp0_reg_data(mem_cp0_reg_data_o),	
.wb_wd(wb_wd_i), .wb_wreg(wb_wreg_i), .wb_wdata(wb_wdata_i),
.wb_hi(wb_hi_i), .wb_lo(wb_lo_i), .wb_whilo(wb_whilo_i),
.wb_cp0_reg_we(wb_cp0_reg_we_i), .wb_cp0_reg_write_addr(wb_cp0_reg_write_addr_i), .wb_cp0_reg_data(wb_cp0_reg_data_i));
//HILO instance
hilo_reg hilo_reg0(.clk(clk), .rst(rst), .write_enable(wb_whilo_i), .hi_i(wb_hi_i), .lo_i(wb_lo_i), 
.hi_o(hi_i), .lo_o(lo_i));
//CTRL instance
ctrl ctrl0(.rst(rst), .stallreq_id(stallreq_id), .stallreq_ex(stallreq_ex), 
.stallreq_if(inst_bus.stall),.stallreq_mem(data_bus.stall),.stall(stall_temp),
.except_info(mem_except_info_o), .flush(flush), .is_load_i(mem_is_load), .mem_we_i(mem_is_save), .clk(clk));

//CP0 instance
CP0_regs_t cp0_regs;
CP0_writeRequest_t cp0_wrr;
Except_request_t except_request;
Except_info_t except_info;
Pipeline_data_t data;

assign cp0_wrr.we = wb_cp0_reg_we_i;
assign cp0_wrr.waddr = wb_cp0_reg_write_addr_i;
assign cp0_wrr.wdata = wb_cp0_reg_data_i;
assign cp0_wrr.sel = 3'b0; // not ok?

assign mem_we_and_ce = ram_write_enable_before_except_o && ram_ce_o;

assign data.delayslot = mem_in_delayslot_o;
assign data.pc = mem_inst_addr_current_o;

assign except_info.inst_addr_miss = mem_except_info_o[14];
assign except_info.inst_addr_illegal = mem_except_info_o[13];
assign except_info.inst_addr_invalid = mem_except_info_o[12];
assign except_info.data_addr_miss = mem_except_info_o[11];
assign except_info.data_addr_illegal = mem_except_info_o[10];
assign except_info.data_addr_invalid = mem_except_info_o[9];
assign except_info.syscall = mem_except_info_o[8];
assign except_info.break0 = mem_except_info_o[7];
assign except_info.overflow = mem_except_info_o[6];
assign except_info.priv_inst = mem_except_info_o[5];
assign except_info.invalid_inst = mem_except_info_o[4];
assign except_info.trap = mem_except_info_o[3];
assign except_info.eret = mem_except_info_o[2];
assign except_info.data_addr_unaligned = mem_except_info_o[1];
assign except_info.data_addr_read_only = mem_except_info_o[0];


assign new_pc = except_request.jump_pc;

cp0_reg cp0_reg0(.clk(clk), .rst(rst), 
.raddr(cp0_reg_read_addr), .rsel(3'b0),
.write_register_request(cp0_wrr),
.regs(cp0_regs),
.rdata(cp0_reg_read_data),
.except_req(except_request)
);

except except0(
.rst(rst),
.except(except_info), 
.data(data),
.is_user_mode(1'b0),  //not ok
.cp0_regs_input(cp0_regs),
.memory_data_writeEnable(mem_we_and_ce), // from mem_write_enable_o & mem_ce_o
//.data_virtual_addr()
.cp0_write_req(cp0_wrr),
//.interrupt_flag(),
.except_req(except_request)
);
endmodule
