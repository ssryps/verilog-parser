//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/22 09:24:35
// Design Name: 
// Module Name: inst_bus
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

`include "per_defs.svh"

module inst_bus(
    Bus_if.slave cpu,
    Bus_if.master ram,
    Bus_if.master bootrom
    );
    
assign bootrom.address = cpu.address[2 +: `BOOTROM_ADDRESS_WIDTH];
assign bootrom.read = 1'b1;
assign bootrom.mask = `BYTE_MASK_FULL;

assign ram.address = cpu.address[2 +: `RAM_ADDRESS_WIDTH];
assign ram.mask = `BYTE_MASK_FULL;

always_comb begin
    ram.read = `ZERO_BIT;
    ram.write = `ZERO_BIT;
    cpu.data_r1 = `ZERO_BIT;
    cpu.data_r2 = `ZERO_BIT;
    cpu.stall = `ZERO_BIT;
    
    unique casez (cpu.address[`ADDRESS_WIDTH - 1 -: `LONGEST_ADDRESS_PREFIX_WIDTH])
        `ADD_PREFIX(RAM): begin
            ram.read = cpu.read;
            ram.write = cpu.write;
            cpu.data_r1 = ram.data_r1;
            cpu.data_r2 = ram.data_r2;
            cpu.stall = ram.stall;
        end
        
        `ADD_PREFIX(BOOTROM): begin
            cpu.data_r1 = bootrom.data_r1;
            cpu.data_r2 = bootrom.data_r2;
            //cpu.stall = bootrom.stall;
            
        end
        
        default:begin end
    endcase
    
end
               
endmodule
