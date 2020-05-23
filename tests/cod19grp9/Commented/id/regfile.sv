`include "../macro.v"
// support read 2 data write 1 data simultaneously
module regfile(
    input wire clk,rst,
    input wire write_enable,
    input wire[`RegAddrBus] write_addr,
    input wire[`RegBus] write_data,
    input wire read_enable_1,
    input wire[`RegAddrBus] read_addr_1,
    output reg[`RegBus] read_data_1,
    input wire read_enable_2,
    input wire[`RegAddrBus] read_addr_2,
    output reg[`RegBus] read_data_2
    );
reg[`RegBus] regs[0:`RegNum - 1];

integer i;

always @ (posedge clk)begin
     if (rst == `RstEnable)begin
        for(i=0; i < $size(regs); i = i + 1)  regs[i] <= 32'b0;
    end
    else begin
        if ((write_enable == `WriteEnable) && (write_addr != `RegNumLog2'b0)) begin
                regs[write_addr] <= write_data;
            end
            else begin end
    
    end
end



// write operation using clk
/*
    always @ (posedge clk) begin
        if (rst == `RstDisable) begin
            if ((write_enable == `WriteEnable) && (write_addr != `RegNumLog2'b0)) begin
                regs[write_addr] <= write_data;
            end
            else begin end
        end
        else begin end
    end
    */
//read operation using always @ (*)
    always @ (*) begin
        if (rst == `RstEnable) begin
            read_data_1 <= `ZeroWord;
        end
        else if (read_addr_1 == `RegNumLog2'b0) begin
            read_data_1 <= `ZeroWord;
        end
        else if ((read_addr_1 == write_addr) && (write_enable == `WriteEnable) && (read_enable_1 == `ReadEnable)) begin
            read_data_1 <= write_data;
        end
        else if (read_enable_1 == `ReadEnable) begin
            read_data_1 <= regs[read_addr_1];
        end
        else begin
            read_data_1 <= `ZeroWord;
        end
    end
    always @ (*) begin
            if (rst == `RstEnable) begin
                read_data_2 <= `ZeroWord;
            end
            else if (read_addr_2 == `RegNumLog2'b0) begin
                read_data_2 <= `ZeroWord;
            end
            else if ((read_addr_2 == write_addr) && (write_enable == `WriteEnable) && (read_enable_2 == `ReadEnable)) begin
                read_data_2 <= write_data;
            end
            else if (read_enable_2 == `ReadEnable) begin
                read_data_2 <= regs[read_addr_2];
            end
            else begin
                read_data_2 <= `ZeroWord;
            end
            
            
        end
   
            
endmodule
