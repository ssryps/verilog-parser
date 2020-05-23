`include "per_defs.svh"
`include "async.v"
//`include "E:/project_1/project_1.srcs/sources_1/new/per_defs.svh"

module uart(
	Bus_if.slave data_bus,
	UART_if.master uart
);

logic interrupt;

`REGISTER_IRQ(UART,interrupt,data_bus.interrupt)

wire clk,bus_clk,uart_clk,rst;
assign clk = data_bus.clk.base_2x;
assign uart_clk = data_bus.clk._11M0592;
assign bus_clk = data_bus.clk.base;
assign rst = data_bus.clk.rst;
assign data_bus.stall = 1'b0;

logic tx_fifo_full, tx_fifo_empty, tx_fifo_read, tx_fifo_write;
Byte_t tx_fifo_out, tx_fifo_in;

fifo_uart_tx transmitter_fifo(
    .srst(rst),
    .clk(clk),
    .din(tx_fifo_in),
    .dout(tx_fifo_out),
    .wr_en(tx_fifo_write),
    .rd_en(tx_fifo_read),
    .full(tx_fifo_full),
    .empty(tx_fifo_empty)
);

logic tx_start,tx_busy;

async_transmitter #(.ClkFrequency(20000000),.Baud(9600)) //发送模块，9600无检验位
    transmitter(
        .clk(clk),                  //外部时钟信号
        .TxD(uart.txd),                      //串行信号输出
        .TxD_busy(tx_busy),       //发送器忙状态指示
        .TxD_start(tx_start),    //开始发送信号
        .TxD_data(tx_fifo_out)        //待发送的数据
    );
    
typedef enum {
        STATE_INIT, STATE_SEND, STATE_WAIT
} FifoConsumerState;

FifoConsumerState currState;

assign tx_fifo_read = (currState == STATE_INIT) && !tx_fifo_empty && !tx_busy;
//assign tx_fifo_read = !tx_fifo_empty & !tx_busy;
//assign tx_fifo_read = !tx_fifo_empty;

always_ff @(posedge clk or posedge rst) begin
    if(rst) begin
        tx_start <= `ZERO_BIT;
        currState <= STATE_INIT;
    end else begin
        tx_start <= `ZERO_BIT;
        case(currState)
            STATE_INIT:begin
                if(tx_busy) begin
                    currState <= STATE_WAIT;
                end else if(!tx_fifo_empty) begin
                    currState <= STATE_SEND;
                    tx_start <= 1'b1;
                end
            end
            STATE_SEND:begin
                currState <= STATE_WAIT;
            end
            STATE_WAIT:begin
                //tx_start <= 1'b0;
                if(!tx_busy) begin
                    currState <= STATE_INIT;
                end
            end
        endcase
     end
end

always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        tx_fifo_in <= `ZERO_BYTE;
        tx_fifo_write <= `ZERO_BIT;
    end else begin
        tx_fifo_write <= `ZERO_BIT;
        if(bus_clk == ~`BUS_CLK_POSEDGE) begin
            if (data_bus.write && data_bus.address[0] == 1'b0 && !tx_fifo_full) begin
                tx_fifo_in <= Byte_t'(data_bus.data_w);
                tx_fifo_write <= 1'b1;
            end
        end
    end
end

Byte_t rx_fifo_in, rx_fifo_out;
logic rx_fifo_write, rx_fifo_empty, rx_fifo_read, rx_clear;
assign interrupt = ~rx_fifo_empty;
assign rx_clear = rx_fifo_write;
fifo_uart_rx receiver_fifo(
    .srst(rst),
    .clk(clk),
    .din(rx_fifo_in),
    .dout(rx_fifo_out),
    .wr_en(rx_fifo_write),
    .rd_en(rx_fifo_read),
    .full(),
    .empty(rx_fifo_empty)
);

async_receiver #(.ClkFrequency(20000000),.Baud(9600)) //接收模块，9600无检验位
    receiver(
        .clk(clk),                       //外部时钟信号
        .RxD(uart.rxd),                           //外部串行信号输入
        .RxD_data_ready(rx_fifo_write),  //数据接收到标志
        .RxD_clear(rx_clear),       //清除接收标志
        .RxD_data(rx_fifo_in)             //接收到的一字节数据
    );
    
always_ff @(posedge clk or posedge rst) begin
    if(rst) begin
        data_bus.data_r1 <= `ZERO_WORD;
        rx_fifo_read <= `ZERO_BIT;
    end else begin
        rx_fifo_read <= `ZERO_BIT;
        if (bus_clk == ~`BUS_CLK_POSEDGE) begin
            if (data_bus.read && data_bus.address[0] == 1'b0 && !rx_fifo_empty) begin
                data_bus.data_r1 <= rx_fifo_out;
                rx_fifo_read <= 1'b1;
            end else if (data_bus.read && data_bus.address[0] == 1'b1) begin
                data_bus.data_r1 <= {30'b0, ~rx_fifo_empty, ~tx_fifo_full};
            end
        end
    end
end

endmodule