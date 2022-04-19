module ahb_lite_fir_filter
(
  input logic clk,
  input logic n_rst,
  input logic hsel,
  input logic [3:0] haddr,
  input logic hsize,
  input logic [1:0] htrans,
  input logic hwrite,
  input logic [15:0] hwdata,
  output logic [15:0] hrdata,
  output logic hresp
);
  logic [15:0] sample_data;
  logic [15:0] fir_coefficient;
  logic [15:0] fir_out;
  logic [1:0] coefficient_num;
  logic err;
  logic data_ready;
  logic modwait;
  logic new_coefficient_set;
  logic coef_clear;
  logic load_coef;

fir_filter filter1
(
    .clk(clk),
    .n_reset(n_rst),
    .sample_data(sample_data),
    .fir_coefficient(fir_coefficient),
    .load_coeff(load_coef),
    .data_ready(data_ready),
    .modwait(modwait),
    .fir_out(fir_out),
    .err(err)
);

ahb_lite_slave slave1
(
    .clk(clk),
    .n_rst(n_rst),
    .sample_data(sample_data),
    .new_coefficient_set(new_coefficient_set),
    .coefficient_num(coefficient_num),
    .fir_coefficient(fir_coefficient),
    .modwait(modwait),
    .data_ready(data_ready),
    .fir_out(fir_out),
    .err(err),
    .hsel(hsel),
    .haddr(haddr),
    .hsize(hsize),
    .htrans(htrans),
    .hwrite(hwrite),
    .hwdata(hwdata),
    .hrdata(hrdata),
    .hresp(hresp),
    .coef_clear(coef_clear)
);

coefficient_loader cf1 (
    .clk(clk),
    .n_reset(n_rst),
    .new_coefficient_set(new_coefficient_set),
    .modwait(modwait),
    .load_coeff(load_coef),
    .coefficient_num(coefficient_num),
    .coef_clear(coef_clear)

);

endmodule