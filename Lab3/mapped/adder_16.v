/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Fri Jan 28 13:07:13 2022
/////////////////////////////////////////////////////////////


module adder_16_DW01_add_0 ( A, B, CI, SUM, CO );
  input [16:0] A;
  input [16:0] B;
  output [16:0] SUM;
  input CI;
  output CO;

  wire   [16:1] carry;
  tri   \A[15] ;
  tri   \A[14] ;
  tri   \A[13] ;
  tri   \A[12] ;
  tri   \A[11] ;
  tri   \A[10] ;
  tri   \A[9] ;
  tri   \A[8] ;
  tri   \A[7] ;
  tri   \A[6] ;
  tri   \A[5] ;
  tri   \A[4] ;
  tri   \A[3] ;
  tri   \A[2] ;
  tri   \A[1] ;
  tri   \A[0] ;
  tri   \B[15] ;
  tri   \B[14] ;
  tri   \B[13] ;
  tri   \B[12] ;
  tri   \B[11] ;
  tri   \B[10] ;
  tri   \B[9] ;
  tri   \B[8] ;
  tri   \B[7] ;
  tri   \B[6] ;
  tri   \B[5] ;
  tri   \B[4] ;
  tri   \B[3] ;
  tri   \B[2] ;
  tri   \B[1] ;
  tri   \B[0] ;
  tri   CI;
  tri   [16:0] SUM;

  FAX1 U1_16 ( .A(1'b0), .B(1'b0), .C(carry[16]), .YS(SUM[16]) );
  FAX1 U1_15 ( .A(A[15]), .B(B[15]), .C(carry[15]), .YC(carry[16]), .YS(
        SUM[15]) );
  FAX1 U1_14 ( .A(A[14]), .B(B[14]), .C(carry[14]), .YC(carry[15]), .YS(
        SUM[14]) );
  FAX1 U1_13 ( .A(A[13]), .B(B[13]), .C(carry[13]), .YC(carry[14]), .YS(
        SUM[13]) );
  FAX1 U1_12 ( .A(A[12]), .B(B[12]), .C(carry[12]), .YC(carry[13]), .YS(
        SUM[12]) );
  FAX1 U1_11 ( .A(A[11]), .B(B[11]), .C(carry[11]), .YC(carry[12]), .YS(
        SUM[11]) );
  FAX1 U1_10 ( .A(A[10]), .B(B[10]), .C(carry[10]), .YC(carry[11]), .YS(
        SUM[10]) );
  FAX1 U1_9 ( .A(A[9]), .B(B[9]), .C(carry[9]), .YC(carry[10]), .YS(SUM[9]) );
  FAX1 U1_8 ( .A(A[8]), .B(B[8]), .C(carry[8]), .YC(carry[9]), .YS(SUM[8]) );
  FAX1 U1_7 ( .A(A[7]), .B(B[7]), .C(carry[7]), .YC(carry[8]), .YS(SUM[7]) );
  FAX1 U1_6 ( .A(A[6]), .B(B[6]), .C(carry[6]), .YC(carry[7]), .YS(SUM[6]) );
  FAX1 U1_5 ( .A(A[5]), .B(B[5]), .C(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  FAX1 U1_4 ( .A(A[4]), .B(B[4]), .C(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  FAX1 U1_3 ( .A(A[3]), .B(B[3]), .C(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  FAX1 U1_2 ( .A(A[2]), .B(B[2]), .C(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  FAX1 U1_1 ( .A(A[1]), .B(B[1]), .C(carry[1]), .YC(carry[2]), .YS(SUM[1]) );
  FAX1 U1_0 ( .A(A[0]), .B(B[0]), .C(CI), .YC(carry[1]), .YS(SUM[0]) );
endmodule


module adder_16 ( a, b, carry_in, sum, overflow );
  input [15:0] a;
  input [15:0] b;
  output [15:0] sum;
  input carry_in;
  output overflow;

  tri   [15:0] a;
  tri   [15:0] b;
  tri   carry_in;
  tri   [15:0] sum;
  tri   overflow;

  adder_nbit IX ( .a(a), .b(b), .carry_in(carry_in), .sum(sum), .overflow(
        overflow) );
  adder_16_DW01_add_0 r304 ( .A({1'b0, a}), .B({1'b0, b}), .CI(carry_in), 
        .SUM({overflow, sum}) );
endmodule

