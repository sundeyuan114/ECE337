/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Fri Jan 28 13:07:16 2022
/////////////////////////////////////////////////////////////


module adder_16_DW01_add_0 ( A, B, CI, SUM, CO );
  input [16:0] A;
  input [16:0] B;
  output [16:0] SUM;
  input CI;
  output CO;
  wire   n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17,
         n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31,
         n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45,
         n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59,
         n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73,
         n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85;
  tri   [16:0] A;
  tri   [16:0] B;
  tri   CI;
  tri   [16:0] SUM;
  tri   \carry[16] ;
  assign SUM[16] = \carry[16] ;

  NAND2X1 U1 ( .A(n3), .B(n4), .Y(\carry[16] ) );
  NAND2X1 U2 ( .A(n6), .B(n7), .Y(n5) );
  INVX2 U3 ( .A(A[0]), .Y(n8) );
  INVX2 U4 ( .A(B[1]), .Y(n9) );
  INVX2 U5 ( .A(A[1]), .Y(n10) );
  AOI21X1 U6 ( .A(n12), .B(n13), .C(n14), .Y(n11) );
  NOR2X1 U7 ( .A(A[2]), .B(B[2]), .Y(n15) );
  NOR2X1 U8 ( .A(A[3]), .B(B[3]), .Y(n16) );
  NOR2X1 U9 ( .A(A[4]), .B(B[4]), .Y(n17) );
  NOR2X1 U10 ( .A(A[5]), .B(B[5]), .Y(n18) );
  NOR2X1 U11 ( .A(A[6]), .B(B[6]), .Y(n19) );
  XOR2X1 U12 ( .A(n20), .B(n21), .Y(SUM[9]) );
  XOR2X1 U13 ( .A(n22), .B(n23), .Y(SUM[8]) );
  XNOR2X1 U14 ( .A(n24), .B(n25), .Y(SUM[7]) );
  XNOR2X1 U15 ( .A(n26), .B(n27), .Y(SUM[6]) );
  XNOR2X1 U16 ( .A(n28), .B(n29), .Y(SUM[5]) );
  XNOR2X1 U17 ( .A(n30), .B(n31), .Y(SUM[4]) );
  XNOR2X1 U18 ( .A(n32), .B(n33), .Y(SUM[3]) );
  XNOR2X1 U19 ( .A(n34), .B(n35), .Y(SUM[2]) );
  XOR2X1 U20 ( .A(n36), .B(n37), .Y(SUM[1]) );
  XNOR2X1 U21 ( .A(n11), .B(n38), .Y(SUM[15]) );
  XOR2X1 U22 ( .A(n13), .B(n39), .Y(SUM[14]) );
  XOR2X1 U23 ( .A(n40), .B(n41), .Y(SUM[13]) );
  XOR2X1 U24 ( .A(n42), .B(n43), .Y(SUM[12]) );
  XOR2X1 U25 ( .A(n44), .B(n45), .Y(SUM[11]) );
  XOR2X1 U26 ( .A(n46), .B(n47), .Y(SUM[10]) );
  XNOR2X1 U27 ( .A(n48), .B(n8), .Y(SUM[0]) );
  XOR2X1 U28 ( .A(B[9]), .B(A[9]), .Y(n21) );
  XOR2X1 U29 ( .A(B[8]), .B(A[8]), .Y(n23) );
  XOR2X1 U30 ( .A(B[7]), .B(A[7]), .Y(n25) );
  XOR2X1 U31 ( .A(B[6]), .B(A[6]), .Y(n27) );
  XOR2X1 U32 ( .A(B[5]), .B(A[5]), .Y(n29) );
  XOR2X1 U33 ( .A(B[4]), .B(A[4]), .Y(n31) );
  XOR2X1 U34 ( .A(B[3]), .B(A[3]), .Y(n33) );
  XOR2X1 U35 ( .A(B[2]), .B(A[2]), .Y(n35) );
  XOR2X1 U36 ( .A(B[1]), .B(A[1]), .Y(n37) );
  XOR2X1 U37 ( .A(B[15]), .B(A[15]), .Y(n38) );
  XOR2X1 U38 ( .A(B[14]), .B(A[14]), .Y(n39) );
  XOR2X1 U39 ( .A(B[13]), .B(A[13]), .Y(n41) );
  XOR2X1 U40 ( .A(B[12]), .B(A[12]), .Y(n43) );
  XOR2X1 U41 ( .A(B[11]), .B(A[11]), .Y(n45) );
  XOR2X1 U42 ( .A(B[10]), .B(A[10]), .Y(n47) );
  XOR2X1 U43 ( .A(B[0]), .B(CI), .Y(n48) );
  NAND2X1 U44 ( .A(A[7]), .B(n50), .Y(n49) );
  NAND2X1 U45 ( .A(A[8]), .B(n22), .Y(n51) );
  NAND2X1 U46 ( .A(A[9]), .B(n20), .Y(n52) );
  NAND2X1 U47 ( .A(A[10]), .B(n46), .Y(n53) );
  NAND2X1 U48 ( .A(A[11]), .B(n44), .Y(n54) );
  NAND2X1 U49 ( .A(A[12]), .B(n42), .Y(n55) );
  NAND2X1 U50 ( .A(A[13]), .B(n40), .Y(n56) );
  OAI21X1 U51 ( .A(CI), .B(B[0]), .C(A[0]), .Y(n57) );
  NAND2X1 U52 ( .A(B[0]), .B(CI), .Y(n58) );
  NAND2X1 U53 ( .A(n58), .B(n57), .Y(n36) );
  OAI21X1 U54 ( .A(n10), .B(n9), .C(n60), .Y(n59) );
  INVX2 U55 ( .A(n59), .Y(n34) );
  OAI21X1 U56 ( .A(n34), .B(n15), .C(n62), .Y(n61) );
  INVX2 U57 ( .A(n61), .Y(n32) );
  OAI21X1 U58 ( .A(n32), .B(n16), .C(n64), .Y(n63) );
  INVX2 U59 ( .A(n63), .Y(n30) );
  OAI21X1 U60 ( .A(n30), .B(n17), .C(n66), .Y(n65) );
  INVX2 U61 ( .A(n65), .Y(n28) );
  OAI21X1 U62 ( .A(n28), .B(n18), .C(n68), .Y(n67) );
  INVX2 U63 ( .A(n67), .Y(n26) );
  OAI21X1 U64 ( .A(n26), .B(n19), .C(n69), .Y(n50) );
  INVX2 U65 ( .A(n50), .Y(n24) );
  NAND2X1 U66 ( .A(B[7]), .B(n50), .Y(n70) );
  NAND3X1 U67 ( .A(n70), .B(n49), .C(n71), .Y(n22) );
  NAND2X1 U68 ( .A(B[8]), .B(n22), .Y(n72) );
  NAND3X1 U69 ( .A(n72), .B(n51), .C(n73), .Y(n20) );
  NAND2X1 U70 ( .A(B[9]), .B(n20), .Y(n74) );
  NAND3X1 U71 ( .A(n74), .B(n52), .C(n75), .Y(n46) );
  NAND2X1 U72 ( .A(B[10]), .B(n46), .Y(n76) );
  NAND3X1 U73 ( .A(n76), .B(n53), .C(n77), .Y(n44) );
  NAND2X1 U74 ( .A(B[11]), .B(n44), .Y(n78) );
  NAND3X1 U75 ( .A(n78), .B(n54), .C(n79), .Y(n42) );
  NAND2X1 U76 ( .A(B[12]), .B(n42), .Y(n80) );
  NAND3X1 U77 ( .A(n80), .B(n55), .C(n81), .Y(n40) );
  NAND2X1 U78 ( .A(B[13]), .B(n40), .Y(n82) );
  NAND3X1 U79 ( .A(n82), .B(n56), .C(n83), .Y(n13) );
  OAI21X1 U80 ( .A(B[15]), .B(n5), .C(A[15]), .Y(n4) );
  NAND2X1 U81 ( .A(B[15]), .B(n5), .Y(n3) );
  NAND2X1 U82 ( .A(B[2]), .B(A[2]), .Y(n62) );
  NAND2X1 U83 ( .A(B[3]), .B(A[3]), .Y(n64) );
  NAND2X1 U84 ( .A(B[4]), .B(A[4]), .Y(n66) );
  NAND2X1 U85 ( .A(B[5]), .B(A[5]), .Y(n68) );
  NAND2X1 U86 ( .A(B[6]), .B(A[6]), .Y(n69) );
  NAND2X1 U87 ( .A(B[7]), .B(A[7]), .Y(n71) );
  NAND2X1 U88 ( .A(B[8]), .B(A[8]), .Y(n73) );
  NAND2X1 U89 ( .A(B[9]), .B(A[9]), .Y(n75) );
  NAND2X1 U90 ( .A(B[10]), .B(A[10]), .Y(n77) );
  NAND2X1 U91 ( .A(B[11]), .B(A[11]), .Y(n79) );
  NAND2X1 U92 ( .A(B[12]), .B(A[12]), .Y(n81) );
  NAND2X1 U93 ( .A(B[13]), .B(A[13]), .Y(n83) );
  NAND2X1 U94 ( .A(B[14]), .B(A[14]), .Y(n7) );
  INVX2 U95 ( .A(n7), .Y(n14) );
  OR2X1 U96 ( .A(A[14]), .B(B[14]), .Y(n84) );
  NAND2X1 U97 ( .A(n84), .B(n13), .Y(n6) );
  OR2X1 U98 ( .A(B[14]), .B(A[14]), .Y(n12) );
  OR2X1 U99 ( .A(A[1]), .B(B[1]), .Y(n85) );
  NAND2X1 U100 ( .A(n85), .B(n36), .Y(n60) );
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

