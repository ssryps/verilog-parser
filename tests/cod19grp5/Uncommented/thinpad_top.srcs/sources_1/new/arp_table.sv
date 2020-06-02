`timescale 1ns / 1ps

`include "constants.vh"

// Linear scan (back to front, maybe faster). If the memory is full, overwrite and continue.
module arp_table #(
    parameter integer BUCKET_INDEX_WIDTH = 3
)(
    input wire clk,
    input wire rst,
    
    input wire [`IPV4_WIDTH-1:0] i_ip,          // search (mac, ip) by ip
    input wire i_valid,
    
    output logic [`MAC_WIDTH-1:0] o_mac,
    output logic o_valid,
    output logic o_not_found,
    
    input wire [`IPV4_WIDTH-1:0] i_insert_ip,    // insert (mac, ip) to memory
    input wire [`MAC_WIDTH-1:0] i_insert_mac,
    input wire i_insert_valid,
    
    output logic ready
);

// insert

integer BUCKET_LAST_INDEX = (2 ** BUCKET_INDEX_WIDTH) - 1;
logic [`ARP_TABLE_ENTRY_WIDTH-1:0] insert_data;
logic [BUCKET_INDEX_WIDTH-1:0] insert_index;
logic insert_we;
logic [`ARP_TABLE_ENTRY_WIDTH-1:0] insert_out_data;
logic ready1;
logic ready2;
assign ready = ready1 && ready2;

always_ff @(posedge clk) begin
    if (rst) begin
        insert_data <= 0;
        insert_index <= 0;
        insert_we <= 0;
        ready1 <= 1;
    end else if (i_insert_valid && ready1) begin
        ready1 <= 0;
        insert_data <= {i_insert_mac, i_insert_ip};
        insert_we <= 1;
    end else if (!ready1 && insert_out_data == insert_data) begin
        if (insert_index == BUCKET_LAST_INDEX) begin // if full, overwrite
            insert_index <= 0;
        end else begin
            insert_index <= insert_index + 1;
        end
        ready1 <= 1;
    end else begin
        insert_data <= 0;
        insert_we <= 0;
    end
end

// search

logic [`ARP_TABLE_ENTRY_WIDTH-1:0] temp_data;
logic [BUCKET_INDEX_WIDTH-1:0] temp_index;
logic [`IPV4_WIDTH-1:0] temp_ip;

always_ff @(posedge clk) begin
    if (rst) begin
        temp_index <= 0;
        o_mac <= 0;
        ready2 <= 1;
        o_valid <= 0;
        o_not_found <= 0;
    end else if (i_valid && ready2) begin
        ready2 <= 0;
        if (insert_index == 0) begin
            temp_index <= BUCKET_LAST_INDEX;
        end else begin
            temp_index <= insert_index - 1;
        end
        temp_ip <= i_ip;
    end else if (!ready2) begin
        if (temp_data == 0 || temp_index == insert_index) begin
            ready2 <= 1;
            o_not_found <= 1;
        end else if (temp_data[`IPV4_WIDTH-1:0] == temp_ip) begin
            o_mac <= temp_data[`ARP_TABLE_ENTRY_WIDTH-1:`IPV4_WIDTH];
            ready2 <= 1;
            o_valid <= 1;
        end else if (temp_index == 0) begin
            temp_index <= BUCKET_LAST_INDEX;
        end else begin
            temp_index <= temp_index - 1;
        end
    end else begin
        o_mac <= 0;
        o_not_found <= 0;
        o_valid <= 0;
    end
end

xpm_memory_tdpram #(
    .ADDR_WIDTH_A(BUCKET_INDEX_WIDTH),
    .BYTE_WRITE_WIDTH_A(`ARP_TABLE_ENTRY_WIDTH),
    .READ_DATA_WIDTH_A(`ARP_TABLE_ENTRY_WIDTH),
    .READ_LATENCY_A(1),
    .WRITE_DATA_WIDTH_A(`ARP_TABLE_ENTRY_WIDTH),
    
    .ADDR_WIDTH_B(BUCKET_INDEX_WIDTH),
    .BYTE_WRITE_WIDTH_B(`ARP_TABLE_ENTRY_WIDTH),
    .READ_DATA_WIDTH_B(`ARP_TABLE_ENTRY_WIDTH),
    .READ_LATENCY_B(0),
    .WRITE_DATA_WIDTH_B(`ARP_TABLE_ENTRY_WIDTH),
    
    .MEMORY_SIZE((2 ** BUCKET_INDEX_WIDTH) * `ARP_TABLE_ENTRY_WIDTH),
    
    .MEMORY_INIT_PARAM("0")
) jgnb_xpm_memory_tdpram (
    .dina(insert_data),
    .addra(insert_index),
    .wea(insert_we),
    .douta(insert_out_data),
    .clka(clk),
    .rsta(rst),
    .ena(1),
    
    .dinb(0),
    .addrb(temp_index),
    .web(0),
    .doutb(temp_data),
    .clkb(clk),
    .rstb(rst),
    .enb(1)
);

endmodule
