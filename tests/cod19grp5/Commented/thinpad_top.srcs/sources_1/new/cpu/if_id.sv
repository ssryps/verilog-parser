`include "defines.vh"

module if_id(
    input wire clk --clock,
    input wire rst --reset,

    //from ctrl message
    input wire[5:0] stall,
    input wire flush,

    input wire[31:0] if_excepttype,
    output reg[31:0] id_excepttype,
    
    input wire[`InstAddrBus] if_pc,
    input wire[`InstBus] if_inst,
    output reg[`InstAddrBus] id_pc --out_signal,
    output reg[`InstBus] id_inst --out_signal
); --this.if_id

always @ (posedge clk) begin
    if (rst == `RstEnable) begin
        id_pc <= `ZeroWord;
        id_inst <= `ZeroWord;
        id_excepttype <= `ZeroWord;
    end else if (flush == 1'b1 ) begin
        id_pc <= `ZeroWord;
        id_inst <= `ZeroWord;
        id_excepttype <= `ZeroWord;
    end else if (stall[1] == `Stop && stall[2] == `NoStop) begin
        id_pc <= `ZeroWord;
        id_inst <= `ZeroWord;
        id_excepttype <= `ZeroWord;
    end else if (stall[1] == `NoStop) begin
        id_pc <= if_pc;
        id_inst <= if_inst;
        id_excepttype <= if_excepttype;
        if (id_excepttype[13] == 1'b1) begin
            id_inst <= `ZeroWord;
        end
    end
end

endmodule
