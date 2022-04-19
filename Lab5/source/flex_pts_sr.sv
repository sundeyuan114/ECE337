// $Id: $
// File name:   flex_pts_sr.sv
// Created:     2/17/2022
// Author:      Deyuan Sun
// Lab Section: 337-06
// Version:     1.0  Initial Design Entry
// Description: lab5

module flex_pts_sr #(
    parameter NUM_BITS = 4,
    parameter SHIFT_MSB = 1'b1
) (
    input logic clk,
    input logic n_rst,
    input logic shift_enable,
    input logic load_enable,
    input logic [NUM_BITS-1:0] parallel_in,
    output logic serial_out
);
    logic [NUM_BITS-1:0] par;
    logic [NUM_BITS-1:0] next_par;

//flip flop
always_ff @( posedge clk, negedge n_rst ) begin : ff
    if (!n_rst) begin
        par <= '1;
    end
    else begin
        par <= next_par;
    end
end
// next state logic
always_comb begin
    if (load_enable) begin
        next_par = parallel_in;
    end
    else if (shift_enable) begin
        next_par = SHIFT_MSB? {par[NUM_BITS-2:0], 1'b1} : {1'b1,par[NUM_BITS-1:1]};
    end
    else begin
        next_par = par;
    end
end
// output logic
assign serial_out = SHIFT_MSB? par[NUM_BITS-1] : par[0];
endmodule