`timescale 1ns / 1ps

`include "constants.vh"

module router_top(
    input wire clk_40M,
    input wire clk_50M,
    input wire clk_125M,
    input wire clk_200M,
    input wire locked,
    input wire reset_btn,
    
    input  wire [3:0] eth_rgmii_rd,
    input  wire eth_rgmii_rx_ctl,
    input  wire eth_rgmii_rxc,
    output wire [3:0] eth_rgmii_td,
    output wire eth_rgmii_tx_ctl,
    output wire eth_rgmii_txc,
    output wire eth_rst_n,

    input  wire eth_int_n,
    input  wire eth_spi_miso,
    output wire eth_spi_mosi,
    output wire eth_spi_sck,
    output wire eth_spi_ss_n,

    input wire rram_w_en,
    input wire [3:0] rram_w_sel,
    input wire [`RRAM_ADDR_WIDTH-1:0] rram_w_addr,
    input wire [31:0] rram_w_data,

    input wire rram_r_en,
    input wire [3:0] rram_r_sel,
    input wire [`RRAM_ADDR_WIDTH-1:0] rram_r_addr,
    output reg [31:0] rram_r_data
);

wire [7:0] eth_rx_axis_mac_tdata;
wire eth_rx_axis_mac_tvalid;
wire eth_rx_axis_mac_tlast;
wire eth_rx_axis_mac_tuser;
wire [7:0] eth_tx_axis_mac_tdata;
wire eth_tx_axis_mac_tvalid;
wire eth_tx_axis_mac_tlast;
wire eth_tx_axis_mac_tuser;
wire eth_tx_axis_mac_tready;

wire eth_rx_mac_aclk;
wire eth_tx_mac_aclk;

assign eth_rst_n = ~reset_btn;
// 以太网交换机寄存器配置
eth_conf conf(
    .clk(clk_50M),
    .rst_in_n(locked),

    .eth_spi_miso(eth_spi_miso),
    .eth_spi_mosi(eth_spi_mosi),
    .eth_spi_sck(eth_spi_sck),
    .eth_spi_ss_n(eth_spi_ss_n),

    .done()
);

logic packet_w_en;
logic [`RRAM_ADDR_WIDTH-1:0] packet_w_addr;
logic [7:0] packet_w_data;

logic packet_r_en;
logic [`RRAM_ADDR_WIDTH-1:0] packet_r_addr;
logic [7:0] packet_r_data;

logic routing_table_update_end;     // 1: set status as 0
logic routing_table_update_status;  // 1: the data from cpu is ready
logic routing_table_update_insert;  // 0: delete, 1: insert
logic [`IPV4_WIDTH-1:0] routing_table_update_item_nxthop;
logic [`IPV4_WIDTH-1:0] routing_table_update_item_ip;
logic [`PORT_WIDTH-1:0] routing_table_update_item_port;
logic [`ROUTING_MASK_WIDTH-1:0] routing_table_update_item_mask;

logic to_cpu_packet_end;      // 1: the packet has been transferred to cpu
logic to_cpu_packet_status;   // 1: the packet to cpu is ready

logic from_cpu_packet_end;    // 1: the packet has been sent
logic from_cpu_packet_status;  // 1: the packet from cpu is ready

rram rram_inst(
    .clk(clk_50M),
    .rst(reset_btn|~locked),

    .w_en(rram_w_en),
    .w_sel(rram_w_sel),
    .w_addr(rram_w_addr),
    .w_data(rram_w_data),

    .r_en(rram_r_en),
    .r_sel(rram_r_sel),
    .r_addr(rram_r_addr),
    .r_data(rram_r_data),

    .packet_w_en(packet_w_en),
    .packet_w_addr(packet_w_addr),
    .packet_w_data(packet_w_data),

    .packet_r_en(packet_r_en),
    .packet_r_addr(packet_r_addr),
    .packet_r_data(packet_r_data),

    .routing_table_update_end(routing_table_update_end),
    .routing_table_update_status(routing_table_update_status),
    .routing_table_update_insert(routing_table_update_insert),
    .routing_table_update_item_nxthop(routing_table_update_item_nxthop),
    .routing_table_update_item_ip(routing_table_update_item_ip),
    .routing_table_update_item_port(routing_table_update_item_port),
    .routing_table_update_item_mask(routing_table_update_item_mask),

    .to_cpu_packet_end(to_cpu_packet_end),
    .to_cpu_packet_status(to_cpu_packet_status),

    .from_cpu_packet_end(from_cpu_packet_end),
    .from_cpu_packet_status(from_cpu_packet_status)
);

wire [`IPV4_WIDTH-1:0] lookup_ip;
wire [`IPV4_WIDTH-1:0] nxthop;
wire [`PORT_WIDTH-1:0] port;
wire o_ready,o_valid,o_not_found,i_ready,i_valid;

routing_table routing_table_inst(
    .clk(clk_50M),
    .rst(reset_btn|~locked),
    .i_dest_ip(lookup_ip),
    .i_valid(i_valid),
    .o_next_ip(nxthop),
    .o_port(port),
    .o_ready(o_ready),
    .o_valid(o_valid),
    .i_ready(i_ready),
    .o_not_found(o_not_found),

    .os_clk(clk_40M),
    .os_rst(reset_btn|~locked),
    .os_update(routing_table_update_status),
    .os_updateready(routing_table_update_end),
    .os_nxthop(routing_table_update_item_nxthop),
    .os_ip(routing_table_update_item_ip),
    .os_port(routing_table_update_item_port),
    .os_mask(routing_table_update_item_mask)
);

eth_handler eth_handler_inst(
    .clk(clk_50M),
    .rst(reset_btn|~locked),
    .eth_rx_mac_aclk(eth_rx_mac_aclk),
    .eth_rx_axis_mac_tdata(eth_rx_axis_mac_tdata),
    .eth_rx_axis_mac_tvalid(eth_rx_axis_mac_tvalid),
    .eth_rx_axis_mac_tlast(eth_rx_axis_mac_tlast),
    .eth_rx_axis_mac_tuser(eth_rx_axis_mac_tuser),

    .eth_tx_mac_aclk(eth_tx_mac_aclk),
    .eth_tx_axis_mac_tdata(eth_tx_axis_mac_tdata),
    .eth_tx_axis_mac_tvalid(eth_tx_axis_mac_tvalid),
    .eth_tx_axis_mac_tlast(eth_tx_axis_mac_tlast),
    .eth_tx_axis_mac_tuser(eth_tx_axis_mac_tuser),
    .eth_tx_axis_mac_tready(eth_tx_axis_mac_tready),
    
    .lookup_ip(lookup_ip),
    .nxthop_ip(nxthop),
    .nxthop_port(port),
    .routing_table_i_ready(o_ready),
    .routing_table_i_valid(o_valid),
    .routing_table_o_valid(i_valid),
    .routing_table_o_ready(i_ready),

    .packet_w_en(packet_w_en),
    .packet_w_addr(packet_w_addr),
    .packet_w_data(packet_w_data),

    .packet_r_en(packet_r_en),
    .packet_r_addr(packet_r_addr),
    .packet_r_data(packet_r_data),

    .to_cpu_packet_end(to_cpu_packet_end),
    .to_cpu_packet_status(to_cpu_packet_status),

    .from_cpu_packet_end(from_cpu_packet_end),
    .from_cpu_packet_status(from_cpu_packet_status)
);


//gen a fifo which can contain 4 rip packet, received rip packet from eth_handler, store in fifo
//if at least has one packet, set dataready to 1


eth_mac eth_mac_inst (
    .gtx_clk(clk_125M),
    .refclk(clk_200M),

    .glbl_rstn(eth_rst_n),
    .rx_axi_rstn(eth_rst_n),
    .tx_axi_rstn(eth_rst_n),

    .rx_mac_aclk(eth_rx_mac_aclk),
    .rx_axis_mac_tdata(eth_rx_axis_mac_tdata),
    .rx_axis_mac_tvalid(eth_rx_axis_mac_tvalid),
    .rx_axis_mac_tlast(eth_rx_axis_mac_tlast),
    .rx_axis_mac_tuser(eth_rx_axis_mac_tuser),

    .tx_ifg_delay(8'b0),
    .tx_mac_aclk(eth_tx_mac_aclk),
    .tx_axis_mac_tdata(eth_tx_axis_mac_tdata),
    .tx_axis_mac_tvalid(eth_tx_axis_mac_tvalid),
    .tx_axis_mac_tlast(eth_tx_axis_mac_tlast),
    .tx_axis_mac_tuser(eth_tx_axis_mac_tuser),
    .tx_axis_mac_tready(eth_tx_axis_mac_tready),

    .pause_req(1'b0),
    .pause_val(16'b0),

    .rgmii_txd(eth_rgmii_td),
    .rgmii_tx_ctl(eth_rgmii_tx_ctl),
    .rgmii_txc(eth_rgmii_txc),
    .rgmii_rxd(eth_rgmii_rd),
    .rgmii_rx_ctl(eth_rgmii_rx_ctl),
    .rgmii_rxc(eth_rgmii_rxc),

    // receive 1Gb/s | promiscuous | flow control | fcs | vlan | enable
    .rx_configuration_vector(80'b10100000101110),
    // transmit 1Gb/s | vlan | enable
    .tx_configuration_vector(80'b10000000000110)
);
    
endmodule
