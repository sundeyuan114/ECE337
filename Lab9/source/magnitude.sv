module magnitude
(
    input logic [16:0] in,
    output logic [15:0] out
);

assign out = in[16] ? (~in[15:0] + 1) : in[15:0];

endmodule