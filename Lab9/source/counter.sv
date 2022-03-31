module counter (
    input logic clk,
    input logic n_rst,
    input logic cnt_up,
    input logic clear,
    output logic one_k_samples
);
     
flex_counter #(11) count_to_1000 (
    .clk(clk),
    .clear(clear),
    .count_enable(cnt_up),
    .rollover_val(11'd1000),
    .rollover_flag(one_k_samples)
);

endmodule