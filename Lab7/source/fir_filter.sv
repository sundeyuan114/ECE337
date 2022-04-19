module fir_filter(
    input logic clk,
    input logic n_reset,
    input logic [15:0] sample_data,
    input logic [15:0] fir_coefficient,
    input logic load_coeff,
    input logic data_ready,

    output logic one_k_samples,
    output logic modwait,
    output logic [15:0] fir_out,
    output logic err
);
    logic lc; 
    logic dr; 
    logic [16:0] in;
    logic overflow;
    logic [2:0] op;
    logic [3:0] src1;
    logic [3:0] src2;
    logic [3:0] dest;
    logic cnt_up;
    logic clear;

    sync_low synclowLC(
    .clk(clk),
    .n_rst(n_reset),
    .async_in(load_coeff),
    .sync_out(lc)
    );

    sync_low synclowDR(
    .clk(clk),
    .n_rst(n_reset),
    .async_in(data_ready),
    .sync_out(dr)
    );

    counter count_to_1k(
    .clk(clk),
    .n_rst(n_reset),
    .cnt_up(cnt_up),
    .clear(clear),
    .one_k_samples(one_k_samples)
    );

    magnitude mag1 (
    .in(in),
    .out(fir_out)
    );

    controller controller1 ( 
        .clk(clk),
        .n_rst(n_reset),
        .dr(dr),
        .lc(lc),
        .overflow(overflow),
        .cnt_up(cnt_up),
        .clear(clear),
        .modwait(modwait),
        .op(op),
        .src1(src1),
        .src2(src2),
        .dest(dest),
        .err(err)
    );

    datapath datapath1(
        .clk(clk),
        .n_reset(n_reset),
        .op(op),
        .src1(src1),
        .src2(src2),
        .dest(dest),
        .ext_data1(sample_data),
        .ext_data2(fir_coefficient),
        .outreg_data(in),
        .overflow(overflow)
    );


endmodule