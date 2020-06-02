`timescale 1ns / 1ps

`include "defines.vh"

module cp0_reg(
    
    input wire clk,
    input wire rst,
    
    
    input wire we_i,
    input wire[4:0] waddr_i,
    input wire[4:0] raddr_i,
    input wire[`RegBus] data_i,
    
    input wire[31:0] excepttype_i,
    input wire[5:0] int_i,
    input wire[31:0] bad_address_i,
    input wire[`RegBus] current_inst_addr_i,
    input wire is_in_delayslot_i,
    
    output reg[`RegBus] data_o,
    output reg[`RegBus] count_o,
    output reg[`RegBus] compare_o,
    output reg[`RegBus] status_o,
    output reg[`RegBus] cause_o,
    output reg[`RegBus] epc_o,
    output reg[`RegBus] config_o,
    output reg[`RegBus] prid_o,
    output reg[`RegBus] ebase_o,
    
    // tlb/mmu
    output reg[`RegBus] index_o, // 0
    output reg[`RegBus] random_o, // 1
    output reg[`RegBus] entrylo0_o, // 2
    output reg[`RegBus] entrylo1_o, // 3
    output reg[`RegBus] pagemask_o, // 5
    output reg[`RegBus] badvaddr_o, // 8
    output reg[`RegBus] entryhi_o, // 10
    
    output reg timer_int_o
    
);

always @ (posedge clk) begin
    if(rst == `RstEnable) begin
        count_o <= `ZeroWord;
        compare_o <= `ZeroWord;
        //status寄存器的CU为0001，表示协处理器CP0存在
        status_o <= 32'b00010000000000000000000000000000;
        cause_o <= `ZeroWord;
        epc_o <= `ZeroWord;
        //config寄存器的BE为1，表示Big-Endian；MT为00，表示没有MMU
        config_o <= 32'b00000000000000001000000000000000;
        //制作者是L，对应的是0x48，类型是0x1，基本类型，版本号是1.0
        prid_o <= 32'b00000000010011000000000100000010;
        timer_int_o <= `InterruptNotAssert;
        ebase_o <= 32'b10000000000000000000000000000000;
        index_o <= `ZeroWord;
        random_o <= `ZeroWord;
        entrylo0_o <= `ZeroWord;
        entrylo1_o <= `ZeroWord;
        pagemask_o <= `ZeroWord;
        badvaddr_o <= `ZeroWord;
        entryhi_o <= `ZeroWord;
    end else begin
        count_o <= count_o + 1 ;
        cause_o[15:10] <= int_i;
        
        if(compare_o != `ZeroWord && count_o == compare_o) begin
            timer_int_o <= `InterruptAssert;
        end
        
        if(we_i == `WriteEnable) begin
            case (waddr_i)
            `CP0_REG_INDEX: begin
                index_o[31] <= data_i[31];
                index_o[30:6] <= 25'b0000000000000000000000000;
                index_o[5:0] <= data_i[5:0];
            end
            `CP0_REG_ENTRYLO0: begin
                entrylo0_o[29:26] <= 4'b0000;
                entrylo0_o[25:0] <= data_i[25:0];
            end
            `CP0_REG_ENTRYLO1: begin
                entrylo1_o[29:26] <= 4'b0000;
                entrylo1_o[25:0] <= data_i[25:0];
            end
            `CP0_REG_PAGEMASK: begin
                pagemask_o[31:29] <= 3'b000;
                pagemask_o[28:13] <= data_i[28:13];
                pagemask_o[12:0] <= 13'b0000000000000;
            end
            `CP0_REG_ENTRYHI: begin
                entryhi_o[31:13] <= data_i[31:13];
                entryhi_o[12:8] <= 5'b00000;
                entryhi_o[7:0] <= data_i[7:0];
            end
            `CP0_REG_COUNT: begin
                count_o <= data_i;
            end
            `CP0_REG_COMPARE: begin
                compare_o <= data_i;
                //count_o <= `ZeroWord;
                timer_int_o <= `InterruptNotAssert;
            end
            `CP0_REG_STATUS: begin
                status_o <= data_i;
            end
            `CP0_REG_EPC: begin
                epc_o <= data_i;
            end
            `CP0_REG_CAUSE: begin
                //cause寄存器只有IP[1:0]、IV、WP字段是可写的
                cause_o[9:8] <= data_i[9:8];
                cause_o[23] <= data_i[23];
                cause_o[22] <= data_i[22];
            end          
            `CP0_REG_EBASE: begin
                ebase_o[29:12] <= data_i[29:12];
            end
            endcase //case addr_i
        end
        
        case (excepttype_i)
        32'h00000001: begin
            if(is_in_delayslot_i == `InDelaySlot ) begin
                epc_o <= current_inst_addr_i - 4 ;
                cause_o[31] <= 1'b1;
            end else begin
                epc_o <= current_inst_addr_i;
                cause_o[31] <= 1'b0;
            end
            status_o[1] <= 1'b1;
            cause_o[6:2] <= 5'b00000;
            
        end
        32'h00000008: begin
            if(status_o[1] == 1'b0) begin
                if(is_in_delayslot_i == `InDelaySlot ) begin
                    epc_o <= current_inst_addr_i - 4 ;
                    cause_o[31] <= 1'b1;
                end else begin
                    epc_o <= current_inst_addr_i;
                    cause_o[31] <= 1'b0;
                end
            end
            status_o[1] <= 1'b1;
            cause_o[6:2] <= 5'b01000;
        end
        32'h0000000a: begin
            if(status_o[1] == 1'b0) begin
                if(is_in_delayslot_i == `InDelaySlot ) begin
                    epc_o <= current_inst_addr_i - 4 ;
                    cause_o[31] <= 1'b1;
                end else begin
                    epc_o <= current_inst_addr_i;
                    cause_o[31] <= 1'b0;
                end
            end
            status_o[1] <= 1'b1;
            cause_o[6:2] <= 5'b01010;
        end
        32'h0000000d: begin
            if(status_o[1] == 1'b0) begin
                if(is_in_delayslot_i == `InDelaySlot ) begin
                    epc_o <= current_inst_addr_i - 4 ;
                    cause_o[31] <= 1'b1;
                end else begin
                    epc_o <= current_inst_addr_i;
                    cause_o[31] <= 1'b0;
                end
            end
            status_o[1] <= 1'b1;
            cause_o[6:2] <= 5'b01101;
        end
        32'h0000000c: begin
            if(status_o[1] == 1'b0) begin
                if(is_in_delayslot_i == `InDelaySlot ) begin
                    epc_o <= current_inst_addr_i - 4 ;
                    cause_o[31] <= 1'b1;
                end else begin
                    epc_o <= current_inst_addr_i;
                    cause_o[31] <= 1'b0;
                end
            end
            status_o[1] <= 1'b1;
            cause_o[6:2] <= 5'b01100;
        end
        32'h00000004: begin
                    if (status_o[1] == 1'b0) begin
                        if (is_in_delayslot_i == `InDelaySlot) begin
                            epc_o <= current_inst_addr_i - 4;
                            cause_o[31] <= 1'b1;
                        end else begin
                            epc_o <= current_inst_addr_i;
                            cause_o[31] <= 1'b0;
                        end
                    end
                    status_o[1] <= 1'b1;
                    cause_o[6:2] <= 5'b00100;
                    badvaddr_o <= bad_address_i;
                end
                32'h00000005: begin
                    if (status_o[1] == 1'b0) begin
                        if (is_in_delayslot_i == `InDelaySlot) begin
                            epc_o <= current_inst_addr_i - 4;
                            cause_o[31] <= 1'b1;
                        end else begin
                            epc_o <= current_inst_addr_i;
                            cause_o[31] <= 1'b0;
                        end
                    end
                    status_o[1] <= 1'b1;
                    cause_o[6:2] <= 5'b00101;
                    badvaddr_o <= bad_address_i;
                end
                32'h0000000e: status_o[1] <= 1'b0;
                32'h0000000f: begin
                    if (status_o[1] == 1'b0) begin
                        if (is_in_delayslot_i == `InDelaySlot) begin
                            epc_o <= current_inst_addr_i - 4;
                            cause_o[31] <= 1'b1;
                        end else begin
                            epc_o <= current_inst_addr_i;
                            cause_o[31] <= 1'b0;
                        end
                    end
                    status_o[1] <= 1'b1;
                    cause_o[6:2] <= 5'b00010;
                    badvaddr_o <= bad_address_i;
                end
                32'h0000000b: begin
                    if (status_o[1] == 1'b0) begin
                        if (is_in_delayslot_i == `InDelaySlot) begin
                            epc_o <= current_inst_addr_i - 4;
                            cause_o[31] <= 1'b1;
                        end else begin
                            epc_o <= current_inst_addr_i;
                            cause_o[31] <= 1'b0;
                        end
                    end
                    status_o[1] <= 1'b1;
                    cause_o[6:2] <= 5'b00011;
                    badvaddr_o <= bad_address_i;
                end
        default: begin
        end
        endcase
    end //if
end //always

always @ (*) begin
    if(rst == `RstEnable) begin
        data_o <= `ZeroWord;
    end else begin
        case (raddr_i)
        `CP0_REG_INDEX: begin
            data_o[31] <= index_o[31];
            data_o[30:6] <= 25'b0000000000000000000000000;
            data_o[5:0] <= index_o[5:0];
        end
        `CP0_REG_ENTRYLO0: begin
            data_o[31:26] <= 6'b000000;
            data_o[25:0] <= entrylo0_o[25:0];
        end
        `CP0_REG_ENTRYLO1: begin
            data_o[31:26] <= 6'b000000;
            data_o[25:0] <= entrylo1_o[25:0];
        end
        `CP0_REG_PAGEMASK: begin
            data_o[31:29] <= 3'b000;
            data_o[28:13] <= pagemask_o[28:13];
            data_o[12:0] <= 13'b0000000000000;
        end
        `CP0_REG_BADVADDR: data_o <= badvaddr_o;
        `CP0_REG_ENTRYHI: begin
            data_o[31:13] <= entryhi_o[31:13];
            data_o[12:8] <= 5'b00000;
            data_o[7:0] <= entryhi_o[7:0];
        end
        `CP0_REG_RANDOM: begin
            data_o <= random_o;
        end
        `CP0_REG_COUNT: begin
            data_o <= count_o ;
        end
        `CP0_REG_COMPARE: begin
            data_o <= compare_o ;
        end
        `CP0_REG_STATUS: begin
            data_o <= status_o ;
        end
        `CP0_REG_CAUSE: begin
            data_o <= cause_o ;
        end
        `CP0_REG_EPC: begin
            data_o <= epc_o ;
        end
        `CP0_REG_PrId: begin
            data_o <= prid_o ;
        end
        `CP0_REG_CONFIG: begin
            data_o <= config_o ;
        end
        `CP0_REG_EBASE: begin
            //data_o <= ebase_o;
            data_o[31:30] <= 2'b00;
            data_o[29:12] <= ebase_o[29:12];
            data_o[11:10] <= 2'b00;
            data_o[9:0] <= ebase_o[9:0];
        end
        default: begin
        end
        endcase //case addr_i
    end //if
end //always

endmodule


