// $Id: $
// File name:   flex_stp_sr.sv
// Created:     2/17/2022
// Author:      Deyuan Sun
// Lab Section: 337-06
// Version:     1.0  Initial Design Entry
// Description: lab5

module flex_stp_sr #(
    parameter NUM_BITS = 4,
    parameter SHIFT_MSB = 1'b1
) (
    input logic clk,
    input logic n_rst,
    input logic shift_enable,
    input logic serial_in,
    output logic [NUM_BITS -1: 0] parallel_out
);
logic [NUM_BITS -1: 0] next_par_out;

// flip flop
always_ff @(posedge clk or negedge n_rst) begin
    if (!n_rst) begin
        parallel_out <= '1;
    end
    else begin
        parallel_out <= next_par_out;
    end
end
// next state logic
always_comb begin : next_state_logic
    if (shift_enable) begin
        if (SHIFT_MSB) begin
            next_par_out = {parallel_out[NUM_BITS -2:0], serial_in};
        end
        else begin
            next_par_out = {serial_in, parallel_out[NUM_BITS -1:1]};
        end
    end      
    else begin
        next_par_out = parallel_out;
    end
end
endmodule