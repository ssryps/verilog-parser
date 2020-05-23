`timescale 1ns / 1ps

`include "defines.vh"

module ex_mem(
    
	input wire clk --clock,
	input wire rst --reset,
	
    //ctrl info
    input wire[5:0] stall,
    input wire flush,
    
	//ex info
	input wire[`RegAddrBus] ex_wd,
    input wire ex_wreg,
    input wire[`RegBus] ex_wdata,
    input wire[`RegBus] ex_hi,
    input wire[`RegBus] ex_lo,
    input wire ex_whilo,

    //load/save
    input wire[`AluOpBus] ex_aluop,
    input wire[`RegBus] ex_mem_addr,
    input wire[`RegBus] ex_reg2,
    
    input wire[`DoubleRegBus] hilo_i,
    input wire[1:0] cnt_i,
    
    input wire ex_cp0_reg_we,
    input wire[4:0] ex_cp0_reg_write_addr,
    input wire[`RegBus] ex_cp0_reg_data,

    input wire[31:0] ex_excepttype,
    input wire ex_is_in_delayslot,
    input wire[`RegBus] ex_current_inst_address,
	
	//to mem info
	output reg[`RegAddrBus] mem_wd --out_signal,
    output reg mem_wreg --out_signal,
    output reg[`RegBus] mem_wdata --out_signal,
    output reg[`RegBus] mem_hi --out_signal,
    output reg[`RegBus] mem_lo --out_signal,
    output reg mem_whilo --out_signal,

    //to mem load/save
    output reg[`AluOpBus] mem_aluop --out_signal,
    output reg[`RegBus] mem_mem_addr --out_signal,
    output reg[`RegBus] mem_reg2 --out_signal,
    
    output reg mem_cp0_reg_we --out_signal,
    output reg[4:0] mem_cp0_reg_write_addr --out_signal,
    output reg[`RegBus] mem_cp0_reg_data --out_signal,
    
    output reg[31:0] mem_excepttype --out_signal,
    output reg mem_is_in_delayslot --out_signal,
    output reg[`RegBus] mem_current_inst_address --out_signal,
    
    output reg[`DoubleRegBus] hilo_o,
    output reg[1:0] cnt_o,
	input wire[`RegBus] ex_inst,
    output reg[`RegBus] mem_inst --out_signal
); --this.ex

always @ (posedge clk) begin
	if (rst == `RstEnable) begin
        mem_wd <= `NOPRegAddr;
        mem_wreg <= `WriteDisable;
        mem_wdata <= `ZeroWord;	
        mem_hi <= `ZeroWord;
        mem_lo <= `ZeroWord;
        mem_whilo <= `WriteDisable;		
        hilo_o <= {`ZeroWord, `ZeroWord};
        cnt_o <= 2'b00;	
        mem_aluop <= `EXE_NOP_OP;
        mem_mem_addr <= `ZeroWord;
        mem_reg2 <= `ZeroWord;
        mem_cp0_reg_we <= `WriteDisable;
        mem_cp0_reg_write_addr <= 5'b00000;
        mem_cp0_reg_data <= `ZeroWord;
        mem_excepttype <= `ZeroWord;
        mem_is_in_delayslot <= `NotInDelaySlot;
        mem_current_inst_address <= `ZeroWord;
        mem_inst <= `ZeroWord;
    end else if (flush == 1'b1 ) begin
        mem_wd <= `NOPRegAddr;
        mem_wreg <= `WriteDisable;
        mem_wdata <= `ZeroWord;
        mem_hi <= `ZeroWord;
        mem_lo <= `ZeroWord;
        mem_whilo <= `WriteDisable;
        mem_aluop <= `EXE_NOP_OP;
        mem_mem_addr <= `ZeroWord;
        mem_reg2 <= `ZeroWord;
        mem_cp0_reg_we <= `WriteDisable;
        mem_cp0_reg_write_addr <= 5'b00000;
        mem_cp0_reg_data <= `ZeroWord;
        mem_excepttype <= `ZeroWord;
        mem_is_in_delayslot <= `NotInDelaySlot;
        mem_current_inst_address <= `ZeroWord;
        hilo_o <= {`ZeroWord, `ZeroWord};
        cnt_o <= 2'b00;
            mem_inst <= `ZeroWord;
    end else if (stall[3] == `Stop && stall[4] == `NoStop) begin
        mem_wd <= `NOPRegAddr;
        mem_wreg <= `WriteDisable;
        mem_wdata <= `ZeroWord;
        mem_hi <= `ZeroWord;
        mem_lo <= `ZeroWord;
        mem_whilo <= `WriteDisable;
        hilo_o <= hilo_i;
        cnt_o <= cnt_i;		
        mem_aluop <= `EXE_NOP_OP;
        mem_mem_addr <= `ZeroWord;
        mem_reg2 <= `ZeroWord;	  			
        mem_cp0_reg_we <= `WriteDisable;
        mem_cp0_reg_write_addr <= 5'b00000;
        mem_cp0_reg_data <= `ZeroWord;
        mem_excepttype <= `ZeroWord;
        mem_is_in_delayslot <= `NotInDelaySlot;
        mem_current_inst_address <= `ZeroWord;	    
        mem_inst <= `ZeroWord;
    end else if (stall[3] == `NoStop) begin
        mem_wd <= ex_wd;
        mem_wreg <= ex_wreg;
        mem_wdata <= ex_wdata;	
        mem_hi <= ex_hi;
        mem_lo <= ex_lo;
        mem_whilo <= ex_whilo;	
        hilo_o <= {`ZeroWord, `ZeroWord};
        cnt_o <= 2'b00;	
        mem_aluop <= ex_aluop;
        mem_mem_addr <= ex_mem_addr;
        mem_reg2 <= ex_reg2;
        mem_cp0_reg_we <= ex_cp0_reg_we;
        mem_cp0_reg_write_addr <= ex_cp0_reg_write_addr;
        mem_cp0_reg_data <= ex_cp0_reg_data;
        mem_excepttype <= ex_excepttype;
        mem_is_in_delayslot <= ex_is_in_delayslot;
        mem_current_inst_address <= ex_current_inst_address;
        mem_inst <= ex_inst;
    end else begin
        hilo_o <= hilo_i;
        cnt_o <= cnt_i;											
    end //if
end //always

endmodule
