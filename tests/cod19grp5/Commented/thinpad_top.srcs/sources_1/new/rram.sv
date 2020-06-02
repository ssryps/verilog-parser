`timescale 1ns / 1ps

`include "constants.vh"

module rram (
    input wire clk,
    input wire rst,

    input wire w_en,  // write enable
    input wire [3:0] w_sel, // byte select
    input wire [`RRAM_ADDR_WIDTH-1:0] w_addr,
    input wire [31:0] w_data,

    input wire r_en, // read enable
    input wire [3:0] r_sel, // byte select
    input wire [`RRAM_ADDR_WIDTH-1:0] r_addr,
    output reg [31:0] r_data,

    input wire packet_w_en, // packet write enable
    input wire [`RRAM_ADDR_WIDTH-1:0] packet_w_addr,
    input wire [7:0] packet_w_data,

    input wire packet_r_en, // packet read enable
    input wire [`RRAM_ADDR_WIDTH-1:0] packet_r_addr,
    output reg [7:0] packet_r_data,

    input wire routing_table_update_end,     // 1: set status as 0
    output reg routing_table_update_status,  // 1: the data from cpu is ready
    output reg routing_table_update_insert,  // 0: delete, 1: insert
    output reg [`IPV4_WIDTH-1:0] routing_table_update_item_nxthop,
    output reg [`IPV4_WIDTH-1:0] routing_table_update_item_ip,
    output reg [`PORT_WIDTH-1:0] routing_table_update_item_port,
    output reg [`ROUTING_MASK_WIDTH-1:0] routing_table_update_item_mask,

    input wire to_cpu_packet_end,      // 1: the packet has been transferred to cpu
    output reg to_cpu_packet_status,   // 1: the packet to cpu is ready

    input wire from_cpu_packet_end,    // 1: the packet has been sent
    output reg from_cpu_packet_status  // 1: the packet from cpu is ready
);

reg [`RRAM_CACHE_SIZE-1:0][7:0] buffer = 0;
reg [63:0] time_ms = 0;
integer tick = 0;

logic xpm_w_en;
logic [3:0] xpm_w_sel;
logic [`RRAM_ADDR_WIDTH-3:0] xpm_w_addr;
logic [31:0] xpm_w_data;
logic [31:0] xpm_w_out_data;

logic xpm_r_en;
logic [3:0] xpm_r_sel;
logic [`RRAM_ADDR_WIDTH-3:0] xpm_r_addr;
logic [31:0] xpm_r_data;

always_ff @(posedge clk) begin
    if (rst) begin
        time_ms <= 0;
        tick <= 0;
    end else begin
        tick <= tick + 1;
        if (tick + 1 == `TICK_PER_MS) begin
            time_ms <= time_ms + 1;
            tick <= 0;
        end
    end
end

always @(*) begin
    buffer[`TIME_MS + 0] <= time_ms[7:0];
    buffer[`TIME_MS + 1] <= time_ms[15:8];
    buffer[`TIME_MS + 2] <= time_ms[23:16];
    buffer[`TIME_MS + 3] <= time_ms[31:24];
    buffer[`TIME_MS + 4] <= time_ms[39:32];
    buffer[`TIME_MS + 5] <= time_ms[47:40];
    buffer[`TIME_MS + 6] <= time_ms[55:48];
    buffer[`TIME_MS + 7] <= time_ms[63:56];
    xpm_w_en <= 0;
    xpm_r_en <= 0;
    if (w_en) begin
        if (w_addr < `RRAM_CACHE_SIZE) begin
            if (w_sel[0]) buffer[w_addr + 0] <= w_data[7:0];
            if (w_sel[1]) buffer[w_addr + 1] <= w_data[15:8];
            if (w_sel[2]) buffer[w_addr + 2] <= w_data[23:16];
            if (w_sel[3]) buffer[w_addr + 3] <= w_data[31:24];
        end else begin
            xpm_w_en <= 1;
            xpm_w_sel <= w_sel;
            xpm_w_addr <= w_addr[`RRAM_ADDR_WIDTH-1:2];
            xpm_w_data <= w_data;
        end
    end else if (packet_w_en) begin
        if (packet_w_addr < `RRAM_CACHE_SIZE) begin
            buffer[packet_w_addr] <= packet_w_data;
        end else begin
            xpm_w_en <= 1;
            xpm_w_addr <= packet_w_addr[`RRAM_ADDR_WIDTH-1:2];
            xpm_w_data <= { packet_w_data, packet_w_data, packet_w_data, packet_w_data };
            case (packet_w_addr[1:0])
                2'b00: xpm_w_sel <= 4'b0001;
                2'b01: xpm_w_sel <= 4'b0010;
                2'b10: xpm_w_sel <= 4'b0100;
                2'b11: xpm_w_sel <= 4'b1000;
            endcase
        end
    end
    if (routing_table_update_end) begin
        buffer[`ROUTING_TABLE_UPDATE_STATUS] <= 8'b0;
    end
    if (to_cpu_packet_end) begin
        buffer[`TO_CPU_PACKET_STATUS] <= 8'b1;
    end
    if (from_cpu_packet_end) begin
        buffer[`FROM_CPU_PACKET_STATUS] <= 8'b0;
    end
    if (r_en) begin
        if (r_addr < `RRAM_CACHE_SIZE) begin
            r_data <= { buffer[r_addr + 3], buffer[r_addr + 2], buffer[r_addr + 1], buffer[r_addr + 0] };
        end else begin
            xpm_r_en <= 1;
            xpm_r_sel <= r_sel;
            xpm_r_addr <= r_addr[`RRAM_ADDR_WIDTH-1:2];
            r_data <= xpm_r_data;
        end
    end else if (packet_r_en) begin
        if (packet_r_addr < `RRAM_CACHE_SIZE) begin
            packet_r_data <= buffer[packet_r_addr];
        end else begin
            xpm_r_en <= 1;
            xpm_r_addr <= packet_r_addr[`RRAM_ADDR_WIDTH-1:2];
            case (packet_r_addr[1:0])
                2'b00: packet_r_data <= xpm_r_data[7:0];
                2'b01: packet_r_data <= xpm_r_data[15:8];
                2'b10: packet_r_data <= xpm_r_data[23:16];
                2'b11: packet_r_data <= xpm_r_data[31:24];
            endcase
        end
    end
end

assign routing_table_update_status = buffer[`ROUTING_TABLE_UPDATE_STATUS][0];
assign routing_table_update_insert = buffer[`ROUTING_TABLE_UPDATE_INSERT][0];
assign routing_table_update_item_nxthop = {
    buffer[`ROUTING_TABLE_UPDATE_ITEM_NXTHOP + 3],
    buffer[`ROUTING_TABLE_UPDATE_ITEM_NXTHOP + 2],
    buffer[`ROUTING_TABLE_UPDATE_ITEM_NXTHOP + 1],
    buffer[`ROUTING_TABLE_UPDATE_ITEM_NXTHOP + 0]
};
assign routing_table_update_item_ip = {
    buffer[`ROUTING_TABLE_UPDATE_ITEM_IP + 3],
    buffer[`ROUTING_TABLE_UPDATE_ITEM_IP + 2],
    buffer[`ROUTING_TABLE_UPDATE_ITEM_IP + 1],
    buffer[`ROUTING_TABLE_UPDATE_ITEM_IP + 0]
};
assign routing_table_update_item_port = buffer[`ROUTING_TABLE_UPDATE_ITEM_PORT][`PORT_WIDTH-1:0];
assign routing_table_update_item_mask = buffer[`ROUTING_TABLE_UPDATE_ITEM_MASK][`ROUTING_MASK_WIDTH-1:0];
assign to_cpu_packet_status = buffer[`TO_CPU_PACKET_STATUS][0];
assign from_cpu_packet_status = buffer[`FROM_CPU_PACKET_STATUS][0];

xpm_memory_tdpram #(
    .ADDR_WIDTH_A(`RRAM_ADDR_WIDTH-2),
    .BYTE_WRITE_WIDTH_A(8),
    .READ_DATA_WIDTH_A(32),
    .READ_LATENCY_A(1),
    .WRITE_DATA_WIDTH_A(32),
    
    .ADDR_WIDTH_B(`RRAM_ADDR_WIDTH-2),
    .BYTE_WRITE_WIDTH_B(8),
    .READ_DATA_WIDTH_B(32),
    .READ_LATENCY_B(1),
    .WRITE_DATA_WIDTH_B(32),
    
    .MEMORY_SIZE((2**(`RRAM_ADDR_WIDTH-2)) * 32),
    
    .MEMORY_INIT_PARAM("0")
) xpm_memory_tdpram_inst (
    .clka(clk),
    .rsta(rst),
    .ena(xpm_w_en),
    .addra(xpm_w_addr),
    .wea(xpm_w_sel),
    .dina(xpm_w_data),
    .douta(xpm_w_out_data),
    
    .clkb(clk),
    .rstb(rst),
    .enb(xpm_r_en),
    .addrb(xpm_r_addr),
    .web(0),
    .dinb(0),
    .doutb(xpm_r_data)
);

endmodule
