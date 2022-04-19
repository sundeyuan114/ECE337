// $Id: $
// File name:   adder_nbit.sv
// Created:     1/26/2022
// Author:      Deyuan Sun
// Lab Section: 337-06
// Version:     1.0  Initial Design Entry
// Description: adder with parameter n

module adder_nbit 
#(
    parameter BIT_WIDTH = 4
)
(
    input logic [BIT_WIDTH-1:0] a,
	input logic [BIT_WIDTH-1:0] b,
	input logic carry_in,
	output logic [BIT_WIDTH-1:0] sum,
	output logic overflow
);

    logic [BIT_WIDTH:0] carrys;
    genvar i;
    assign carrys[0] = carry_in;
    generate 
        for(i = 0; i < BIT_WIDTH; i++)
        begin
            adder_1bit IX (.a(a[i]), .b(b[i]), .carry_in(carrys[i]), .sum(sum[i]), .carry_out(carrys[i+1]));
        end
    endgenerate
    assign overflow = carrys[BIT_WIDTH];

endmodule