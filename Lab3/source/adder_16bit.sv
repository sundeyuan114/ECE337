// File name:   adder_16.sv
// Created:     1/19/2015
// Author:      Tim Pritchett
// Version:     1.0  Initial Design Entry
// Description: 16 bit adder design wrapper for synthesis optimization seciton of Lab 2
`timescale 1ns / 100ps

module adder_16bit
(
	input wire [15:0] a,
	input wire [15:0] b,
	input wire carry_in,
	output wire [15:0] sum,
	output wire overflow
);
	// assign sum = ((a + b + carry_in) % (2 **16));
	// assign overflow = ((a + b + carry_in) / (2 ** 16));

	genvar i;
	generate
	for(i = 0; i < 16; i = i + 1)
	begin
		always @ (a[i], b[i], carry_in)
		begin
			#(2)	assert (a[i] == 1'b1 || a[i] == 1'b0 || b[i] == 1'b1 || b[i] == 1'b0 || carry_in == 1'b1 || carry_in == 1'b0) 
			else $error("16bit wrong");   
		end
	end
	endgenerate



	adder_nbit #(16) IX (.a(a), .b(b), .carry_in(carry_in), .sum(sum), .overflow(overflow));

endmodule

// module adder_8bit
// (
// 	input wire [7:0] a,
// 	input wire [7:0] b,
// 	input wire carry_in,
// 	output wire [7:0] sum,
// 	output wire overflow
// );

// 	// STUDENT: Fill in the correct port map with parameter override syntax for using your n-bit ripple carry adder design to be an 8-bit ripple carry adder design
// 	adder_nbit #(8) IX (.a(a), .b(b), .carry_in(carry_in), .sum(sum), .overflow(overflow));
// endmodule