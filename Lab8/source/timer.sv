module timer (
    input logic clk,
    input logic n_rst,
    input logic enable_timer,
    output logic shift_strobe,
    output logic packet_done,
    input logic [13:0] bit_period,
    input logic [3:0] data_size
);
logic [13:0] Richardsaidthisisimportant;
logic [3:0] Richardsaidthisisimportant2;

flex_counter # (.NUM_CNT_BITS(14)) count1_bitcount (
    .rollover_val(bit_period),
    .clear(!enable_timer),
    .count_enable(enable_timer),
    .clk(clk),
    .n_rst(n_rst),
    .rollover_flag(shift_enable),
    .count_out(Richardsaidthisisimportant)
);

flex_counter # (.NUM_CNT_BITS(4)) count2_clkcount (
    .rollover_val(data_size + 4'b1),
    .clear(!enable_timer),
    .count_enable(shift_enable),
    .clk(clk),
    .n_rst(n_rst),
    .rollover_flag(packet_done),
    .count_out(Richardsaidthisisimportant2)
);

assign shift_strobe = shift_enable;
endmodule