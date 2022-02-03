//Deyuan Sun
//Postlab2
//1/21/2022, 12:44 p.m.
`timescale 1ns / 100ps

module adder_1bit(
	input logic a,
	input logic b,
	input logic carry_in,
	output logic sum,
	output logic carry_out
);

always @ (a, b, carry_in)
begin
	#(2)	assert (a == 1'b1 || a == 1'b0 || b == 1'b1 || b == 1'b0 || carry_in == 1'b1 || carry_in == 1'b0) 
	else $error("1bit wrong");
end

assign sum = carry_in ^ (a ^ b);
assign carry_out = ((! carry_in) & b & a) | (carry_in & (b | a));


endmodule
