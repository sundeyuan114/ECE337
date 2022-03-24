module timer (
    input logic clk,
    input logic n_rst,
    input logic enable_timer,
    output logic shift_strobe,
    output logic packet_done
);
logic [3:0] Richardsaidthisisimportant;
logic [3:0] Richardsaidthisisimportant2;

flex_counter # (.NUM_CNT_BITS(4)) count1_bitcount (
    .rollover_val(4'd10),
    .clear(!enable_timer),
    .count_enable(enable_timer),
    .clk(clk),
    .n_rst(n_rst),
    .rollover_flag(shift_enable),
    .count_out(Richardsaidthisisimportant)
);

flex_counter # (.NUM_CNT_BITS(4)) count2_clkcount (
    .rollover_val(4'd9),
    .clear(!enable_timer),
    .count_enable(shift_enable),
    .clk(clk),
    .n_rst(n_rst),
    .rollover_flag(packet_done),
    .count_out(Richardsaidthisisimportant2)
);

assign shift_strobe = shift_enable;
endmodule