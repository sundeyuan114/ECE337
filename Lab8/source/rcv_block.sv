module rcv_block(
    input logic clk,
    input logic n_rst,
    input logic serial_in,
    input logic data_read,
    output logic [7:0] rx_data,
    output logic data_ready,
    output logic overrun_error,
    output logic framing_error,

    input logic [3:0] data_size,
    input logic [13:0] data_period
);

    logic new_packet_detected;
    logic load_buffer;
    logic enable_timer;
    logic packet_done;
    logic sbc_clear;
    logic sbc_enable;
    logic shift_strobe;
    logic stop_bit;
    logic [7:0] packet_data;
    logic [7:0] packet_dat2;
    logic start_bit_detected;

    //change according to datasize
    always_comb begin : rx_data_mux_for_shifting
        if (data_size == 3'd7) begin
            packet_data = {1'b0, packet_dat2[7:1]}; // rx_data[7:1]????
        end
        else if (data_size == 3'd5) begin
            packet_data = {3'b000, packet_dat2[7:3]};
        end
        else begin
            packet_data = packet_dat2;
        end

    end
    //

    rx_data_buff buff1(
        .clk(clk),
        .n_rst(n_rst),
        .load_buffer(load_buffer),
        .packet_data(packet_data),
        .data_read(data_read),
        .rx_data(rx_data),
        .data_ready(data_ready),
        .overrun_error(overrun_error)
    );

    rcu rcu1 (
        .clk(clk),
        .n_rst(n_rst),
        .new_packet_detected(new_packet_detected),
        .packet_done(packet_done),
        .framing_error(framing_error),
        .sbc_clear(sbc_clear),
        .sbc_enable(sbc_enable),
        .load_buffer(load_buffer),
        .enable_timer(enable_timer)
    );

    timer timer1 (
    .clk(clk),
    .n_rst(n_rst),
    .enable_timer(enable_timer),
    .shift_strobe(shift_strobe),
    .packet_done(packet_done),
    .bit_period(data_period),
    .data_size(data_size)
    );

    sr_9bit sr_9bit1 (
     .clk(clk),
     .n_rst(n_rst),
     .shift_strobe(shift_strobe),
     .serial_in(serial_in),
     .packet_data(packet_dat2),
     .stop_bit(stop_bit)
    );

    start_bit_det start1 (
        .clk(clk),
        .n_rst(n_rst),
        .serial_in(serial_in),
        .start_bit_detected(start_bit_detected),
        .new_packet_detected(new_packet_detected)
    );

    stop_bit_chk stop1 (
        .clk(clk),
        .n_rst(n_rst),
        .sbc_clear(sbc_clear),
        .sbc_enable(sbc_enable),
        .stop_bit(stop_bit),
        .framing_error(framing_error)
    );




endmodule