/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Thu Mar 24 21:52:38 2022
/////////////////////////////////////////////////////////////


module rx_data_buff ( clk, n_rst, load_buffer, packet_data, data_read, rx_data, 
        data_ready, overrun_error );
  input [7:0] packet_data;
  output [7:0] rx_data;
  input clk, n_rst, load_buffer, data_read;
  output data_ready, overrun_error;
  wire   n30, n31, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n15, n17, n19,
         n21, n23, n25, n27, n29;

  DFFSR \rx_data_reg[7]  ( .D(n17), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rx_data[7]) );
  DFFSR \rx_data_reg[6]  ( .D(n15), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rx_data[6]) );
  DFFSR \rx_data_reg[5]  ( .D(n21), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rx_data[5]) );
  DFFSR \rx_data_reg[4]  ( .D(n19), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rx_data[4]) );
  DFFSR \rx_data_reg[3]  ( .D(n23), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rx_data[3]) );
  DFFSR \rx_data_reg[2]  ( .D(n25), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rx_data[2]) );
  DFFSR \rx_data_reg[1]  ( .D(n27), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rx_data[1]) );
  DFFSR \rx_data_reg[0]  ( .D(n29), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rx_data[0]) );
  DFFSR data_ready_reg ( .D(n31), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        data_ready) );
  DFFSR overrun_error_reg ( .D(n30), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        overrun_error) );
  INVX1 U3 ( .A(n1), .Y(n15) );
  MUX2X1 U4 ( .B(rx_data[6]), .A(packet_data[6]), .S(load_buffer), .Y(n1) );
  INVX1 U5 ( .A(n2), .Y(n17) );
  MUX2X1 U6 ( .B(rx_data[7]), .A(packet_data[7]), .S(load_buffer), .Y(n2) );
  INVX1 U7 ( .A(n3), .Y(n19) );
  MUX2X1 U8 ( .B(rx_data[4]), .A(packet_data[4]), .S(load_buffer), .Y(n3) );
  INVX1 U9 ( .A(n4), .Y(n21) );
  MUX2X1 U10 ( .B(rx_data[5]), .A(packet_data[5]), .S(load_buffer), .Y(n4) );
  INVX1 U11 ( .A(n5), .Y(n23) );
  MUX2X1 U12 ( .B(rx_data[3]), .A(packet_data[3]), .S(load_buffer), .Y(n5) );
  INVX1 U13 ( .A(n6), .Y(n25) );
  MUX2X1 U14 ( .B(rx_data[2]), .A(packet_data[2]), .S(load_buffer), .Y(n6) );
  INVX1 U15 ( .A(n7), .Y(n27) );
  MUX2X1 U16 ( .B(rx_data[1]), .A(packet_data[1]), .S(load_buffer), .Y(n7) );
  INVX1 U17 ( .A(n8), .Y(n29) );
  MUX2X1 U18 ( .B(rx_data[0]), .A(packet_data[0]), .S(load_buffer), .Y(n8) );
  OAI21X1 U19 ( .A(data_read), .B(n9), .C(n10), .Y(n31) );
  INVX1 U20 ( .A(load_buffer), .Y(n10) );
  INVX1 U21 ( .A(data_ready), .Y(n9) );
  NOR2X1 U22 ( .A(data_read), .B(n11), .Y(n30) );
  AOI21X1 U23 ( .A(data_ready), .B(load_buffer), .C(overrun_error), .Y(n11) );
endmodule


module rcu ( clk, n_rst, new_packet_detected, packet_done, framing_error, 
        sbc_clear, sbc_enable, load_buffer, enable_timer );
  input clk, n_rst, new_packet_detected, packet_done, framing_error;
  output sbc_clear, sbc_enable, load_buffer, enable_timer;
  wire   n25, n26, n27, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15,
         n16, n17, n18, n19, n20;
  wire   [2:0] state;

  DFFSR \state_reg[0]  ( .D(n27), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[0])
         );
  DFFSR \state_reg[1]  ( .D(n26), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[1])
         );
  DFFSR \state_reg[2]  ( .D(n25), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[2])
         );
  NOR2X1 U6 ( .A(n4), .B(n5), .Y(load_buffer) );
  INVX1 U7 ( .A(n6), .Y(sbc_enable) );
  INVX1 U8 ( .A(n7), .Y(sbc_clear) );
  NAND2X1 U9 ( .A(n8), .B(n9), .Y(n27) );
  MUX2X1 U10 ( .B(n10), .A(n11), .S(n5), .Y(n8) );
  NOR2X1 U11 ( .A(state[2]), .B(n12), .Y(n11) );
  MUX2X1 U12 ( .B(packet_done), .A(new_packet_detected), .S(n13), .Y(n12) );
  INVX1 U13 ( .A(n14), .Y(n10) );
  OAI21X1 U14 ( .A(n13), .B(n14), .C(n15), .Y(n26) );
  OAI21X1 U15 ( .A(n16), .B(n14), .C(n17), .Y(n25) );
  AND2X1 U16 ( .A(n6), .B(n9), .Y(n17) );
  NAND2X1 U17 ( .A(n18), .B(n19), .Y(n9) );
  NOR2X1 U18 ( .A(state[0]), .B(framing_error), .Y(n18) );
  NAND3X1 U19 ( .A(n15), .B(n6), .C(n4), .Y(n14) );
  INVX1 U20 ( .A(n19), .Y(n4) );
  NOR2X1 U21 ( .A(n16), .B(state[1]), .Y(n19) );
  NAND3X1 U22 ( .A(state[0]), .B(n16), .C(state[1]), .Y(n6) );
  INVX1 U23 ( .A(enable_timer), .Y(n15) );
  OAI21X1 U24 ( .A(n13), .B(n20), .C(n7), .Y(enable_timer) );
  NAND3X1 U25 ( .A(n13), .B(n16), .C(state[0]), .Y(n7) );
  NAND2X1 U26 ( .A(n5), .B(n16), .Y(n20) );
  INVX1 U27 ( .A(state[2]), .Y(n16) );
  INVX1 U28 ( .A(state[0]), .Y(n5) );
  INVX1 U29 ( .A(state[1]), .Y(n13) );
endmodule


module flex_counter_NUM_CNT_BITS14_DW01_inc_0 ( A, SUM );
  input [13:0] A;
  output [13:0] SUM;

  wire   [13:2] carry;

  HAX1 U1_1_12 ( .A(A[12]), .B(carry[12]), .YC(carry[13]), .YS(SUM[12]) );
  HAX1 U1_1_11 ( .A(A[11]), .B(carry[11]), .YC(carry[12]), .YS(SUM[11]) );
  HAX1 U1_1_10 ( .A(A[10]), .B(carry[10]), .YC(carry[11]), .YS(SUM[10]) );
  HAX1 U1_1_9 ( .A(A[9]), .B(carry[9]), .YC(carry[10]), .YS(SUM[9]) );
  HAX1 U1_1_8 ( .A(A[8]), .B(carry[8]), .YC(carry[9]), .YS(SUM[8]) );
  HAX1 U1_1_7 ( .A(A[7]), .B(carry[7]), .YC(carry[8]), .YS(SUM[7]) );
  HAX1 U1_1_6 ( .A(A[6]), .B(carry[6]), .YC(carry[7]), .YS(SUM[6]) );
  HAX1 U1_1_5 ( .A(A[5]), .B(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  HAX1 U1_1_4 ( .A(A[4]), .B(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  HAX1 U1_1_3 ( .A(A[3]), .B(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  HAX1 U1_1_2 ( .A(A[2]), .B(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  HAX1 U1_1_1 ( .A(A[1]), .B(A[0]), .YC(carry[2]), .YS(SUM[1]) );
  INVX2 U1 ( .A(A[0]), .Y(SUM[0]) );
  XOR2X1 U2 ( .A(carry[13]), .B(A[13]), .Y(SUM[13]) );
endmodule


module flex_counter_NUM_CNT_BITS14_DW01_dec_0 ( A, SUM );
  input [14:0] A;
  output [14:0] SUM;
  wire   n5, n7, n9, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22,
         n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33;

  INVX2 U1 ( .A(n19), .Y(SUM[7]) );
  INVX2 U2 ( .A(n32), .Y(SUM[11]) );
  INVX2 U3 ( .A(n29), .Y(SUM[13]) );
  INVX2 U4 ( .A(n15), .Y(SUM[9]) );
  INVX2 U5 ( .A(A[6]), .Y(n5) );
  INVX2 U6 ( .A(n22), .Y(SUM[5]) );
  INVX2 U7 ( .A(A[4]), .Y(n7) );
  INVX2 U8 ( .A(n25), .Y(SUM[3]) );
  INVX2 U9 ( .A(A[2]), .Y(n9) );
  INVX2 U10 ( .A(n28), .Y(SUM[1]) );
  INVX2 U11 ( .A(A[0]), .Y(SUM[0]) );
  INVX2 U12 ( .A(A[12]), .Y(n12) );
  INVX2 U13 ( .A(A[10]), .Y(n13) );
  INVX2 U14 ( .A(A[8]), .Y(n14) );
  AOI21X1 U15 ( .A(n16), .B(A[9]), .C(n17), .Y(n15) );
  OAI21X1 U16 ( .A(n18), .B(n14), .C(n16), .Y(SUM[8]) );
  AOI21X1 U17 ( .A(n20), .B(A[7]), .C(n18), .Y(n19) );
  OAI21X1 U18 ( .A(n21), .B(n5), .C(n20), .Y(SUM[6]) );
  AOI21X1 U19 ( .A(n23), .B(A[5]), .C(n21), .Y(n22) );
  OAI21X1 U20 ( .A(n24), .B(n7), .C(n23), .Y(SUM[4]) );
  AOI21X1 U21 ( .A(n26), .B(A[3]), .C(n24), .Y(n25) );
  OAI21X1 U22 ( .A(n27), .B(n9), .C(n26), .Y(SUM[2]) );
  AOI21X1 U23 ( .A(A[0]), .B(A[1]), .C(n27), .Y(n28) );
  AOI21X1 U24 ( .A(n30), .B(A[13]), .C(SUM[14]), .Y(n29) );
  NOR2X1 U25 ( .A(n30), .B(A[13]), .Y(SUM[14]) );
  OAI21X1 U26 ( .A(n31), .B(n12), .C(n30), .Y(SUM[12]) );
  NAND2X1 U27 ( .A(n31), .B(n12), .Y(n30) );
  AOI21X1 U28 ( .A(n33), .B(A[11]), .C(n31), .Y(n32) );
  NOR2X1 U29 ( .A(n33), .B(A[11]), .Y(n31) );
  OAI21X1 U30 ( .A(n17), .B(n13), .C(n33), .Y(SUM[10]) );
  NAND2X1 U31 ( .A(n17), .B(n13), .Y(n33) );
  NOR2X1 U32 ( .A(n16), .B(A[9]), .Y(n17) );
  NAND2X1 U33 ( .A(n18), .B(n14), .Y(n16) );
  NOR2X1 U34 ( .A(n20), .B(A[7]), .Y(n18) );
  NAND2X1 U35 ( .A(n21), .B(n5), .Y(n20) );
  NOR2X1 U36 ( .A(n23), .B(A[5]), .Y(n21) );
  NAND2X1 U37 ( .A(n24), .B(n7), .Y(n23) );
  NOR2X1 U38 ( .A(n26), .B(A[3]), .Y(n24) );
  NAND2X1 U39 ( .A(n27), .B(n9), .Y(n26) );
  NOR2X1 U40 ( .A(A[1]), .B(A[0]), .Y(n27) );
endmodule


module flex_counter_NUM_CNT_BITS14 ( clk, n_rst, clear, count_enable, 
        rollover_val, count_out, rollover_flag );
  input [13:0] rollover_val;
  output [13:0] count_out;
  input clk, n_rst, clear, count_enable;
  output rollover_flag;
  wire   N4, N5, N6, N7, N8, N9, N10, N11, N12, N13, N14, N15, N16, N17, N18,
         N23, N24, N25, N26, N27, N28, N29, N30, N31, N32, N33, N34, N35, N36,
         n86, n87, n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99,
         n100, n1, n2, n4, n5, n6, n7, n8, n9, n25, n26, n27, n28, n29, n30,
         n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44,
         n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58,
         n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72,
         n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n101,
         n102, n103, n104, n105, n106, n107, n108, n109, n110, n111, n112,
         n113, n114, n115, n116, n117, n118, n119, n120, n121, n122, n123,
         n124, n125, n126, n127, n128, n129, n130, n131, n132, n133, n134,
         n135;

  DFFSR \count_out_reg[0]  ( .D(n100), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[0]) );
  DFFSR rollover_flag_reg ( .D(n86), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        rollover_flag) );
  DFFSR \count_out_reg[13]  ( .D(n87), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[13]) );
  DFFSR \count_out_reg[1]  ( .D(n99), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[1]) );
  DFFSR \count_out_reg[2]  ( .D(n98), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[2]) );
  DFFSR \count_out_reg[3]  ( .D(n97), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[3]) );
  DFFSR \count_out_reg[4]  ( .D(n96), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[4]) );
  DFFSR \count_out_reg[5]  ( .D(n95), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[5]) );
  DFFSR \count_out_reg[6]  ( .D(n94), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[6]) );
  DFFSR \count_out_reg[7]  ( .D(n93), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[7]) );
  DFFSR \count_out_reg[8]  ( .D(n92), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[8]) );
  DFFSR \count_out_reg[9]  ( .D(n91), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[9]) );
  DFFSR \count_out_reg[10]  ( .D(n90), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[10]) );
  DFFSR \count_out_reg[11]  ( .D(n89), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[11]) );
  DFFSR \count_out_reg[12]  ( .D(n88), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[12]) );
  flex_counter_NUM_CNT_BITS14_DW01_inc_0 r315 ( .A(count_out), .SUM({N36, N35, 
        N34, N33, N32, N31, N30, N29, N28, N27, N26, N25, N24, N23}) );
  flex_counter_NUM_CNT_BITS14_DW01_dec_0 sub_36 ( .A({1'b0, rollover_val}), 
        .SUM({N18, N17, N16, N15, N14, N13, N12, N11, N10, N9, N8, N7, N6, N5, 
        N4}) );
  INVX2 U8 ( .A(n53), .Y(n2) );
  OAI21X1 U20 ( .A(n1), .B(n2), .C(n4), .Y(n99) );
  NAND2X1 U21 ( .A(N24), .B(n5), .Y(n4) );
  OAI21X1 U22 ( .A(n6), .B(n2), .C(n7), .Y(n98) );
  NAND2X1 U23 ( .A(N25), .B(n5), .Y(n7) );
  OAI21X1 U24 ( .A(n8), .B(n2), .C(n9), .Y(n97) );
  NAND2X1 U25 ( .A(N26), .B(n5), .Y(n9) );
  OAI21X1 U26 ( .A(n25), .B(n2), .C(n26), .Y(n96) );
  NAND2X1 U27 ( .A(N27), .B(n5), .Y(n26) );
  OAI21X1 U28 ( .A(n27), .B(n2), .C(n28), .Y(n95) );
  NAND2X1 U29 ( .A(N28), .B(n5), .Y(n28) );
  OAI21X1 U30 ( .A(n29), .B(n2), .C(n30), .Y(n94) );
  NAND2X1 U31 ( .A(N29), .B(n5), .Y(n30) );
  OAI21X1 U32 ( .A(n31), .B(n2), .C(n32), .Y(n93) );
  NAND2X1 U33 ( .A(N30), .B(n5), .Y(n32) );
  OAI21X1 U34 ( .A(n33), .B(n2), .C(n34), .Y(n92) );
  NAND2X1 U35 ( .A(N31), .B(n5), .Y(n34) );
  OAI21X1 U36 ( .A(n35), .B(n2), .C(n36), .Y(n91) );
  NAND2X1 U37 ( .A(N32), .B(n5), .Y(n36) );
  OAI21X1 U38 ( .A(n37), .B(n2), .C(n38), .Y(n90) );
  NAND2X1 U39 ( .A(N33), .B(n5), .Y(n38) );
  OAI21X1 U40 ( .A(n39), .B(n2), .C(n40), .Y(n89) );
  NAND2X1 U41 ( .A(N34), .B(n5), .Y(n40) );
  OAI21X1 U42 ( .A(n41), .B(n2), .C(n42), .Y(n88) );
  NAND2X1 U43 ( .A(N35), .B(n5), .Y(n42) );
  OAI21X1 U44 ( .A(n43), .B(n2), .C(n44), .Y(n87) );
  NAND2X1 U45 ( .A(N36), .B(n5), .Y(n44) );
  MUX2X1 U46 ( .B(n45), .A(n46), .S(n2), .Y(n86) );
  NAND2X1 U47 ( .A(n47), .B(n48), .Y(n46) );
  INVX1 U48 ( .A(rollover_flag), .Y(n45) );
  INVX1 U49 ( .A(n49), .Y(n100) );
  AOI21X1 U50 ( .A(N23), .B(n5), .C(n50), .Y(n49) );
  MUX2X1 U51 ( .B(n51), .A(n52), .S(n2), .Y(n50) );
  NAND3X1 U52 ( .A(n54), .B(n48), .C(n55), .Y(n52) );
  INVX1 U53 ( .A(n56), .Y(n55) );
  INVX1 U54 ( .A(clear), .Y(n48) );
  INVX1 U55 ( .A(n57), .Y(n5) );
  OAI21X1 U56 ( .A(n47), .B(n56), .C(n58), .Y(n57) );
  NOR2X1 U57 ( .A(clear), .B(n53), .Y(n58) );
  NOR2X1 U58 ( .A(count_enable), .B(clear), .Y(n53) );
  OAI21X1 U59 ( .A(count_out[13]), .B(n59), .C(n60), .Y(n56) );
  OAI21X1 U60 ( .A(rollover_val[13]), .B(n43), .C(n61), .Y(n60) );
  OAI21X1 U61 ( .A(count_out[12]), .B(n62), .C(n63), .Y(n61) );
  OAI21X1 U62 ( .A(rollover_val[12]), .B(n41), .C(n64), .Y(n63) );
  AOI21X1 U63 ( .A(count_out[11]), .B(n65), .C(n66), .Y(n64) );
  AOI21X1 U64 ( .A(n39), .B(n67), .C(rollover_val[11]), .Y(n66) );
  INVX1 U65 ( .A(count_out[11]), .Y(n39) );
  INVX1 U66 ( .A(n67), .Y(n65) );
  OAI21X1 U67 ( .A(count_out[10]), .B(n68), .C(n69), .Y(n67) );
  OAI21X1 U68 ( .A(rollover_val[10]), .B(n37), .C(n70), .Y(n69) );
  AOI21X1 U69 ( .A(count_out[9]), .B(n71), .C(n72), .Y(n70) );
  AOI21X1 U70 ( .A(n35), .B(n73), .C(rollover_val[9]), .Y(n72) );
  INVX1 U71 ( .A(n73), .Y(n71) );
  OAI21X1 U72 ( .A(count_out[8]), .B(n74), .C(n75), .Y(n73) );
  OAI21X1 U73 ( .A(rollover_val[8]), .B(n33), .C(n76), .Y(n75) );
  AOI21X1 U74 ( .A(count_out[7]), .B(n77), .C(n78), .Y(n76) );
  AOI21X1 U75 ( .A(n31), .B(n79), .C(rollover_val[7]), .Y(n78) );
  INVX1 U76 ( .A(count_out[7]), .Y(n31) );
  INVX1 U77 ( .A(n79), .Y(n77) );
  OAI21X1 U78 ( .A(count_out[6]), .B(n80), .C(n81), .Y(n79) );
  OAI21X1 U79 ( .A(rollover_val[6]), .B(n29), .C(n82), .Y(n81) );
  AOI21X1 U80 ( .A(count_out[5]), .B(n83), .C(n84), .Y(n82) );
  AOI21X1 U81 ( .A(n27), .B(n85), .C(rollover_val[5]), .Y(n84) );
  INVX1 U82 ( .A(count_out[5]), .Y(n27) );
  INVX1 U83 ( .A(n85), .Y(n83) );
  OAI21X1 U84 ( .A(count_out[4]), .B(n101), .C(n102), .Y(n85) );
  OAI21X1 U85 ( .A(rollover_val[4]), .B(n25), .C(n103), .Y(n102) );
  AOI21X1 U86 ( .A(count_out[3]), .B(n104), .C(n105), .Y(n103) );
  AOI21X1 U87 ( .A(n8), .B(n106), .C(rollover_val[3]), .Y(n105) );
  INVX1 U88 ( .A(count_out[3]), .Y(n8) );
  INVX1 U89 ( .A(n106), .Y(n104) );
  OAI21X1 U90 ( .A(count_out[2]), .B(n107), .C(n108), .Y(n106) );
  OAI21X1 U91 ( .A(rollover_val[2]), .B(n6), .C(n109), .Y(n108) );
  AOI21X1 U92 ( .A(count_out[1]), .B(n110), .C(n111), .Y(n109) );
  AOI21X1 U93 ( .A(n112), .B(n1), .C(rollover_val[1]), .Y(n111) );
  INVX1 U94 ( .A(n110), .Y(n112) );
  NAND2X1 U95 ( .A(rollover_val[0]), .B(n51), .Y(n110) );
  INVX1 U96 ( .A(count_out[0]), .Y(n51) );
  INVX1 U97 ( .A(rollover_val[2]), .Y(n107) );
  INVX1 U98 ( .A(count_out[4]), .Y(n25) );
  INVX1 U99 ( .A(rollover_val[4]), .Y(n101) );
  INVX1 U100 ( .A(rollover_val[6]), .Y(n80) );
  INVX1 U101 ( .A(count_out[8]), .Y(n33) );
  INVX1 U102 ( .A(rollover_val[8]), .Y(n74) );
  INVX1 U103 ( .A(rollover_val[10]), .Y(n68) );
  INVX1 U104 ( .A(count_out[12]), .Y(n41) );
  INVX1 U105 ( .A(rollover_val[12]), .Y(n62) );
  INVX1 U106 ( .A(count_out[13]), .Y(n43) );
  INVX1 U107 ( .A(rollover_val[13]), .Y(n59) );
  INVX1 U108 ( .A(n54), .Y(n47) );
  NAND2X1 U109 ( .A(n113), .B(n114), .Y(n54) );
  NOR2X1 U110 ( .A(n115), .B(n116), .Y(n114) );
  NAND3X1 U111 ( .A(n117), .B(n118), .C(n119), .Y(n116) );
  NOR2X1 U112 ( .A(n120), .B(n121), .Y(n119) );
  XNOR2X1 U113 ( .A(n37), .B(N14), .Y(n121) );
  INVX1 U114 ( .A(count_out[10]), .Y(n37) );
  XNOR2X1 U115 ( .A(n35), .B(N13), .Y(n120) );
  INVX1 U116 ( .A(count_out[9]), .Y(n35) );
  XNOR2X1 U117 ( .A(count_out[11]), .B(N15), .Y(n118) );
  XNOR2X1 U118 ( .A(count_out[12]), .B(N16), .Y(n117) );
  NAND3X1 U119 ( .A(n122), .B(n123), .C(n124), .Y(n115) );
  NOR2X1 U120 ( .A(N18), .B(n125), .Y(n124) );
  XNOR2X1 U121 ( .A(n29), .B(N10), .Y(n125) );
  INVX1 U122 ( .A(count_out[6]), .Y(n29) );
  XNOR2X1 U123 ( .A(count_out[7]), .B(N11), .Y(n123) );
  XNOR2X1 U124 ( .A(count_out[8]), .B(N12), .Y(n122) );
  NOR2X1 U125 ( .A(n126), .B(n127), .Y(n113) );
  NAND3X1 U126 ( .A(n128), .B(n129), .C(n130), .Y(n127) );
  XNOR2X1 U127 ( .A(count_out[4]), .B(N8), .Y(n130) );
  XNOR2X1 U128 ( .A(count_out[5]), .B(N9), .Y(n129) );
  XNOR2X1 U129 ( .A(count_out[3]), .B(N7), .Y(n128) );
  NAND3X1 U130 ( .A(n131), .B(n132), .C(n133), .Y(n126) );
  NOR2X1 U131 ( .A(n134), .B(n135), .Y(n133) );
  XNOR2X1 U132 ( .A(n6), .B(N6), .Y(n135) );
  INVX1 U133 ( .A(count_out[2]), .Y(n6) );
  XNOR2X1 U134 ( .A(n1), .B(N5), .Y(n134) );
  INVX1 U135 ( .A(count_out[1]), .Y(n1) );
  XNOR2X1 U136 ( .A(count_out[13]), .B(N17), .Y(n132) );
  XNOR2X1 U137 ( .A(count_out[0]), .B(N4), .Y(n131) );
endmodule


module flex_counter_NUM_CNT_BITS4 ( clk, n_rst, clear, count_enable, 
        rollover_val, count_out, rollover_flag );
  input [3:0] rollover_val;
  output [3:0] count_out;
  input clk, n_rst, clear, count_enable;
  output rollover_flag;
  wire   n52, n53, n54, n55, n56, n1, n2, n3, n4, n5, n6, n7, n8, n9, n15, n16,
         n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30,
         n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44,
         n45, n46, n47, n48, n49, n50;

  DFFSR \count_out_reg[0]  ( .D(n56), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[0]) );
  DFFSR \count_out_reg[3]  ( .D(n53), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[3]) );
  DFFSR \count_out_reg[2]  ( .D(n54), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[2]) );
  DFFSR \count_out_reg[1]  ( .D(n55), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[1]) );
  DFFSR rollover_flag_reg ( .D(n52), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        rollover_flag) );
  OAI21X1 U7 ( .A(n1), .B(n2), .C(n3), .Y(n56) );
  OAI21X1 U9 ( .A(n4), .B(n1), .C(n5), .Y(n3) );
  INVX1 U10 ( .A(n6), .Y(n4) );
  INVX1 U11 ( .A(n7), .Y(n2) );
  MUX2X1 U12 ( .B(n8), .A(n9), .S(count_out[1]), .Y(n55) );
  NAND2X1 U13 ( .A(n15), .B(count_out[0]), .Y(n8) );
  MUX2X1 U14 ( .B(n16), .A(n17), .S(count_out[2]), .Y(n54) );
  INVX1 U15 ( .A(n18), .Y(n17) );
  OR2X1 U16 ( .A(n19), .B(n20), .Y(n16) );
  OAI21X1 U17 ( .A(n19), .B(n21), .C(n22), .Y(n53) );
  OAI21X1 U18 ( .A(n15), .B(n18), .C(count_out[3]), .Y(n22) );
  OAI21X1 U19 ( .A(count_out[1]), .B(n20), .C(n9), .Y(n18) );
  AOI21X1 U20 ( .A(n1), .B(n15), .C(n7), .Y(n9) );
  NAND2X1 U21 ( .A(n15), .B(count_out[2]), .Y(n21) );
  INVX1 U22 ( .A(n20), .Y(n15) );
  NAND2X1 U23 ( .A(n5), .B(n6), .Y(n20) );
  OAI21X1 U24 ( .A(count_out[3]), .B(n23), .C(n24), .Y(n6) );
  OAI21X1 U25 ( .A(n25), .B(n26), .C(rollover_val[3]), .Y(n24) );
  INVX1 U26 ( .A(count_out[3]), .Y(n26) );
  INVX1 U27 ( .A(n25), .Y(n23) );
  OAI22X1 U28 ( .A(n27), .B(n28), .C(count_out[2]), .D(n29), .Y(n25) );
  OAI21X1 U29 ( .A(rollover_val[1]), .B(n1), .C(n30), .Y(n28) );
  NAND2X1 U30 ( .A(n19), .B(n31), .Y(n27) );
  NAND2X1 U31 ( .A(count_out[1]), .B(count_out[0]), .Y(n19) );
  OAI21X1 U32 ( .A(n32), .B(n33), .C(n34), .Y(n52) );
  NAND2X1 U33 ( .A(rollover_flag), .B(n7), .Y(n34) );
  NAND2X1 U34 ( .A(n35), .B(n36), .Y(n33) );
  MUX2X1 U35 ( .B(n37), .A(n38), .S(n39), .Y(n36) );
  NOR2X1 U36 ( .A(rollover_val[3]), .B(rollover_val[2]), .Y(n38) );
  OAI21X1 U37 ( .A(count_out[2]), .B(n29), .C(n30), .Y(n37) );
  INVX1 U38 ( .A(n40), .Y(n30) );
  OAI21X1 U39 ( .A(rollover_val[2]), .B(n41), .C(n42), .Y(n40) );
  OAI21X1 U40 ( .A(n43), .B(n44), .C(count_out[1]), .Y(n42) );
  INVX1 U41 ( .A(rollover_val[2]), .Y(n29) );
  MUX2X1 U42 ( .B(n1), .A(n45), .S(rollover_val[0]), .Y(n35) );
  OAI21X1 U43 ( .A(count_out[1]), .B(n44), .C(n1), .Y(n45) );
  INVX1 U44 ( .A(count_out[0]), .Y(n1) );
  NAND3X1 U45 ( .A(n46), .B(n47), .C(n5), .Y(n32) );
  NOR2X1 U46 ( .A(n7), .B(clear), .Y(n5) );
  NOR2X1 U47 ( .A(count_enable), .B(clear), .Y(n7) );
  OAI21X1 U48 ( .A(n48), .B(n49), .C(n39), .Y(n47) );
  INVX1 U49 ( .A(n31), .Y(n39) );
  INVX1 U50 ( .A(count_out[1]), .Y(n49) );
  XOR2X1 U51 ( .A(n41), .B(rollover_val[2]), .Y(n48) );
  INVX1 U52 ( .A(count_out[2]), .Y(n41) );
  XOR2X1 U53 ( .A(n50), .B(count_out[3]), .Y(n46) );
  OAI21X1 U54 ( .A(rollover_val[2]), .B(n31), .C(rollover_val[3]), .Y(n50) );
  NAND2X1 U55 ( .A(n43), .B(n44), .Y(n31) );
  INVX1 U56 ( .A(rollover_val[1]), .Y(n44) );
  INVX1 U57 ( .A(rollover_val[0]), .Y(n43) );
endmodule


module timer ( clk, n_rst, enable_timer, shift_strobe, packet_done, bit_period, 
        data_size );
  input [13:0] bit_period;
  input [3:0] data_size;
  input clk, n_rst, enable_timer;
  output shift_strobe, packet_done;
  wire   \_1_net_[3] , \_1_net_[2] , \_1_net_[1] , n1, n2, n3, n4, n5;

  flex_counter_NUM_CNT_BITS14 count1_bitcount ( .clk(clk), .n_rst(n_rst), 
        .clear(n4), .count_enable(enable_timer), .rollover_val(bit_period), 
        .rollover_flag(shift_strobe) );
  flex_counter_NUM_CNT_BITS4 count2_clkcount ( .clk(clk), .n_rst(n_rst), 
        .clear(n4), .count_enable(shift_strobe), .rollover_val({\_1_net_[3] , 
        \_1_net_[2] , \_1_net_[1] , n5}), .rollover_flag(packet_done) );
  INVX1 U2 ( .A(enable_timer), .Y(n4) );
  INVX1 U3 ( .A(data_size[0]), .Y(n5) );
  XOR2X1 U4 ( .A(data_size[3]), .B(n1), .Y(\_1_net_[3] ) );
  NOR2X1 U5 ( .A(n2), .B(n3), .Y(n1) );
  XOR2X1 U6 ( .A(n3), .B(n2), .Y(\_1_net_[2] ) );
  NAND2X1 U7 ( .A(data_size[1]), .B(data_size[0]), .Y(n2) );
  INVX1 U8 ( .A(data_size[2]), .Y(n3) );
  XOR2X1 U9 ( .A(data_size[1]), .B(data_size[0]), .Y(\_1_net_[1] ) );
endmodule


module flex_stp_sr_NUM_BITS9_SHIFT_MSB0 ( clk, n_rst, shift_enable, serial_in, 
        parallel_out );
  output [8:0] parallel_out;
  input clk, n_rst, shift_enable, serial_in;
  wire   n13, n15, n17, n19, n21, n23, n25, n27, n29, n1, n2, n3, n4, n5, n6,
         n7, n8, n9;

  DFFSR \parallel_out_reg[8]  ( .D(n29), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[8]) );
  DFFSR \parallel_out_reg[7]  ( .D(n27), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[7]) );
  DFFSR \parallel_out_reg[6]  ( .D(n25), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[6]) );
  DFFSR \parallel_out_reg[5]  ( .D(n23), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[5]) );
  DFFSR \parallel_out_reg[4]  ( .D(n21), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[4]) );
  DFFSR \parallel_out_reg[3]  ( .D(n19), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[3]) );
  DFFSR \parallel_out_reg[2]  ( .D(n17), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[2]) );
  DFFSR \parallel_out_reg[1]  ( .D(n15), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[1]) );
  DFFSR \parallel_out_reg[0]  ( .D(n13), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[0]) );
  INVX1 U2 ( .A(n1), .Y(n29) );
  MUX2X1 U3 ( .B(parallel_out[8]), .A(serial_in), .S(shift_enable), .Y(n1) );
  INVX1 U4 ( .A(n2), .Y(n27) );
  MUX2X1 U5 ( .B(parallel_out[7]), .A(parallel_out[8]), .S(shift_enable), .Y(
        n2) );
  INVX1 U6 ( .A(n3), .Y(n25) );
  MUX2X1 U7 ( .B(parallel_out[6]), .A(parallel_out[7]), .S(shift_enable), .Y(
        n3) );
  INVX1 U8 ( .A(n4), .Y(n23) );
  MUX2X1 U9 ( .B(parallel_out[5]), .A(parallel_out[6]), .S(shift_enable), .Y(
        n4) );
  INVX1 U10 ( .A(n5), .Y(n21) );
  MUX2X1 U11 ( .B(parallel_out[4]), .A(parallel_out[5]), .S(shift_enable), .Y(
        n5) );
  INVX1 U12 ( .A(n6), .Y(n19) );
  MUX2X1 U13 ( .B(parallel_out[3]), .A(parallel_out[4]), .S(shift_enable), .Y(
        n6) );
  INVX1 U14 ( .A(n7), .Y(n17) );
  MUX2X1 U15 ( .B(parallel_out[2]), .A(parallel_out[3]), .S(shift_enable), .Y(
        n7) );
  INVX1 U16 ( .A(n8), .Y(n15) );
  MUX2X1 U17 ( .B(parallel_out[1]), .A(parallel_out[2]), .S(shift_enable), .Y(
        n8) );
  INVX1 U18 ( .A(n9), .Y(n13) );
  MUX2X1 U19 ( .B(parallel_out[0]), .A(parallel_out[1]), .S(shift_enable), .Y(
        n9) );
endmodule


module sr_9bit ( clk, n_rst, shift_strobe, serial_in, packet_data, stop_bit );
  output [7:0] packet_data;
  input clk, n_rst, shift_strobe, serial_in;
  output stop_bit;


  flex_stp_sr_NUM_BITS9_SHIFT_MSB0 wrapper_stp_bit9_MSB0 ( .clk(clk), .n_rst(
        n_rst), .shift_enable(shift_strobe), .serial_in(serial_in), 
        .parallel_out({stop_bit, packet_data}) );
endmodule


module start_bit_det ( clk, n_rst, serial_in, start_bit_detected, 
        new_packet_detected );
  input clk, n_rst, serial_in;
  output start_bit_detected, new_packet_detected;
  wire   start_bit_detected, old_sample, new_sample, sync_phase, n4;
  assign new_packet_detected = start_bit_detected;

  DFFSR sync_phase_reg ( .D(serial_in), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        sync_phase) );
  DFFSR new_sample_reg ( .D(sync_phase), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        new_sample) );
  DFFSR old_sample_reg ( .D(new_sample), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        old_sample) );
  NOR2X1 U6 ( .A(new_sample), .B(n4), .Y(start_bit_detected) );
  INVX1 U7 ( .A(old_sample), .Y(n4) );
endmodule


module stop_bit_chk ( clk, n_rst, sbc_clear, sbc_enable, stop_bit, 
        framing_error );
  input clk, n_rst, sbc_clear, sbc_enable, stop_bit;
  output framing_error;
  wire   n5, n2, n3;

  DFFSR framing_error_reg ( .D(n5), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        framing_error) );
  NOR2X1 U3 ( .A(sbc_clear), .B(n2), .Y(n5) );
  MUX2X1 U4 ( .B(framing_error), .A(n3), .S(sbc_enable), .Y(n2) );
  INVX1 U5 ( .A(stop_bit), .Y(n3) );
endmodule


module rcv_block ( clk, n_rst, serial_in, data_read, rx_data, data_ready, 
        overrun_error, framing_error, data_size, data_period );
  output [7:0] rx_data;
  input [3:0] data_size;
  input [13:0] data_period;
  input clk, n_rst, serial_in, data_read;
  output data_ready, overrun_error, framing_error;
  wire   load_buffer, new_packet_detected, packet_done, sbc_clear, sbc_enable,
         enable_timer, shift_strobe, stop_bit, n1, n2, n3, n4, n5, n6, n7, n8,
         n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20;
  wire   [7:0] packet_dat2;
  wire   [7:0] packet_data;

  rx_data_buff buff1 ( .clk(clk), .n_rst(n_rst), .load_buffer(load_buffer), 
        .packet_data(packet_data), .data_read(data_read), .rx_data(rx_data), 
        .data_ready(data_ready), .overrun_error(overrun_error) );
  rcu rcu1 ( .clk(clk), .n_rst(n_rst), .new_packet_detected(
        new_packet_detected), .packet_done(packet_done), .framing_error(
        framing_error), .sbc_clear(sbc_clear), .sbc_enable(sbc_enable), 
        .load_buffer(load_buffer), .enable_timer(enable_timer) );
  timer timer1 ( .clk(clk), .n_rst(n_rst), .enable_timer(enable_timer), 
        .shift_strobe(shift_strobe), .packet_done(packet_done), .bit_period(
        data_period), .data_size(data_size) );
  sr_9bit sr_9bit1 ( .clk(clk), .n_rst(n_rst), .shift_strobe(shift_strobe), 
        .serial_in(serial_in), .packet_data(packet_dat2), .stop_bit(stop_bit)
         );
  start_bit_det start1 ( .clk(clk), .n_rst(n_rst), .serial_in(serial_in), 
        .new_packet_detected(new_packet_detected) );
  stop_bit_chk stop1 ( .clk(clk), .n_rst(n_rst), .sbc_clear(sbc_clear), 
        .sbc_enable(sbc_enable), .stop_bit(stop_bit), .framing_error(
        framing_error) );
  NOR2X1 U2 ( .A(n1), .B(n2), .Y(packet_data[7]) );
  OAI22X1 U3 ( .A(n2), .B(n3), .C(n1), .D(n4), .Y(packet_data[6]) );
  INVX1 U4 ( .A(packet_dat2[7]), .Y(n2) );
  OAI22X1 U5 ( .A(n4), .B(n3), .C(n1), .D(n5), .Y(packet_data[5]) );
  INVX1 U6 ( .A(packet_dat2[6]), .Y(n4) );
  OAI21X1 U7 ( .A(n3), .B(n5), .C(n6), .Y(packet_data[4]) );
  AOI22X1 U8 ( .A(packet_dat2[4]), .B(n7), .C(n8), .D(packet_dat2[7]), .Y(n6)
         );
  INVX1 U9 ( .A(packet_dat2[5]), .Y(n5) );
  OAI21X1 U10 ( .A(n3), .B(n9), .C(n10), .Y(packet_data[3]) );
  AOI22X1 U11 ( .A(packet_dat2[3]), .B(n7), .C(n8), .D(packet_dat2[6]), .Y(n10) );
  INVX1 U12 ( .A(packet_dat2[4]), .Y(n9) );
  OAI21X1 U13 ( .A(n3), .B(n11), .C(n12), .Y(packet_data[2]) );
  AOI22X1 U14 ( .A(packet_dat2[2]), .B(n7), .C(n8), .D(packet_dat2[5]), .Y(n12) );
  INVX1 U15 ( .A(packet_dat2[3]), .Y(n11) );
  OAI21X1 U16 ( .A(n3), .B(n13), .C(n14), .Y(packet_data[1]) );
  AOI22X1 U17 ( .A(packet_dat2[1]), .B(n7), .C(n8), .D(packet_dat2[4]), .Y(n14) );
  INVX1 U18 ( .A(packet_dat2[2]), .Y(n13) );
  OAI21X1 U19 ( .A(n3), .B(n15), .C(n16), .Y(packet_data[0]) );
  AOI22X1 U20 ( .A(packet_dat2[0]), .B(n7), .C(packet_dat2[3]), .D(n8), .Y(n16) );
  INVX1 U21 ( .A(n17), .Y(n8) );
  INVX1 U22 ( .A(n1), .Y(n7) );
  NAND2X1 U23 ( .A(n3), .B(n17), .Y(n1) );
  NAND3X1 U24 ( .A(data_size[2]), .B(data_size[0]), .C(n18), .Y(n17) );
  NOR2X1 U25 ( .A(data_size[3]), .B(data_size[1]), .Y(n18) );
  INVX1 U26 ( .A(packet_dat2[1]), .Y(n15) );
  NAND3X1 U27 ( .A(data_size[1]), .B(data_size[2]), .C(n19), .Y(n3) );
  NOR2X1 U28 ( .A(data_size[3]), .B(n20), .Y(n19) );
  INVX1 U29 ( .A(data_size[0]), .Y(n20) );
endmodule


module apb_slave ( clk, n_rst, rx_data, data_ready, overrun_error, 
        framing_error, psel, paddr, penable, pwrite, pwdata, data_read, prdata, 
        pslverr, data_size, bit_period );
  input [7:0] rx_data;
  input [2:0] paddr;
  input [7:0] pwdata;
  output [7:0] prdata;
  output [3:0] data_size;
  output [13:0] bit_period;
  input clk, n_rst, data_ready, overrun_error, framing_error, psel, penable,
         pwrite;
  output data_read, pslverr;
  wire   n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51,
         n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65,
         n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79,
         n80, n81, n82, n83, n84, n85, n86, n87, n88, n89, n90, n91, n92, n93,
         n94, n95, n96, n97, n98, n99, n100, n101, n102, n103, n104, n105,
         n106, n107, n108, n109, n110, n111, n112, n113, n114, n115, n116,
         n117, n118, n119, n120, n121;
  wire   [7:0] next_prdata;
  wire   [7:0] real_rx_data;
  wire   [7:0] next_bit_period_7_0;
  wire   [7:6] bit_period_13_8;
  wire   [7:0] next_bit_period_13_8;
  wire   [7:0] next_temp_data_size;

  DFFSR \real_rx_data_reg[7]  ( .D(rx_data[7]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(real_rx_data[7]) );
  DFFSR \real_rx_data_reg[6]  ( .D(rx_data[6]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(real_rx_data[6]) );
  DFFSR \real_rx_data_reg[5]  ( .D(rx_data[5]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(real_rx_data[5]) );
  DFFSR \real_rx_data_reg[4]  ( .D(rx_data[4]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(real_rx_data[4]) );
  DFFSR \real_rx_data_reg[3]  ( .D(rx_data[3]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(real_rx_data[3]) );
  DFFSR \real_rx_data_reg[2]  ( .D(rx_data[2]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(real_rx_data[2]) );
  DFFSR \real_rx_data_reg[1]  ( .D(rx_data[1]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(real_rx_data[1]) );
  DFFSR \real_rx_data_reg[0]  ( .D(rx_data[0]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(real_rx_data[0]) );
  DFFSR data_read_reg ( .D(n121), .CLK(clk), .R(n_rst), .S(1'b1), .Q(data_read) );
  DFFSR \bit_period_7_0_reg[7]  ( .D(next_bit_period_7_0[7]), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(bit_period[7]) );
  DFFSR \bit_period_7_0_reg[6]  ( .D(next_bit_period_7_0[6]), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(bit_period[6]) );
  DFFSR \bit_period_7_0_reg[5]  ( .D(next_bit_period_7_0[5]), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(bit_period[5]) );
  DFFSR \bit_period_7_0_reg[4]  ( .D(next_bit_period_7_0[4]), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(bit_period[4]) );
  DFFSR \bit_period_7_0_reg[3]  ( .D(next_bit_period_7_0[3]), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(bit_period[3]) );
  DFFSR \bit_period_7_0_reg[2]  ( .D(next_bit_period_7_0[2]), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(bit_period[2]) );
  DFFSR \bit_period_7_0_reg[1]  ( .D(next_bit_period_7_0[1]), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(bit_period[1]) );
  DFFSR \bit_period_7_0_reg[0]  ( .D(next_bit_period_7_0[0]), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(bit_period[0]) );
  DFFSR \bit_period_13_8_reg[7]  ( .D(next_bit_period_13_8[7]), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(bit_period_13_8[7]) );
  DFFSR \bit_period_13_8_reg[6]  ( .D(next_bit_period_13_8[6]), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(bit_period_13_8[6]) );
  DFFSR \bit_period_13_8_reg[5]  ( .D(next_bit_period_13_8[5]), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(bit_period[13]) );
  DFFSR \bit_period_13_8_reg[4]  ( .D(next_bit_period_13_8[4]), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(bit_period[12]) );
  DFFSR \bit_period_13_8_reg[3]  ( .D(next_bit_period_13_8[3]), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(bit_period[11]) );
  DFFSR \bit_period_13_8_reg[2]  ( .D(next_bit_period_13_8[2]), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(bit_period[10]) );
  DFFSR \bit_period_13_8_reg[1]  ( .D(next_bit_period_13_8[1]), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(bit_period[9]) );
  DFFSR \bit_period_13_8_reg[0]  ( .D(next_bit_period_13_8[0]), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(bit_period[8]) );
  DFFSR \prdata_reg[7]  ( .D(next_prdata[7]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(prdata[7]) );
  DFFSR \prdata_reg[6]  ( .D(next_prdata[6]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(prdata[6]) );
  DFFSR \prdata_reg[5]  ( .D(next_prdata[5]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(prdata[5]) );
  DFFSR \prdata_reg[4]  ( .D(next_prdata[4]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(prdata[4]) );
  DFFSR \temp_data_size_reg[3]  ( .D(next_temp_data_size[3]), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(data_size[3]) );
  DFFSR \prdata_reg[3]  ( .D(next_prdata[3]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(prdata[3]) );
  DFFSR \temp_data_size_reg[2]  ( .D(next_temp_data_size[2]), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(data_size[2]) );
  DFFSR \prdata_reg[2]  ( .D(next_prdata[2]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(prdata[2]) );
  DFFSR \temp_data_size_reg[1]  ( .D(next_temp_data_size[1]), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(data_size[1]) );
  DFFSR \prdata_reg[1]  ( .D(next_prdata[1]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(prdata[1]) );
  DFFSR \temp_data_size_reg[0]  ( .D(next_temp_data_size[0]), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(data_size[0]) );
  DFFSR \prdata_reg[0]  ( .D(next_prdata[0]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(prdata[0]) );
  AND2X1 U12 ( .A(n38), .B(n39), .Y(pslverr) );
  OAI21X1 U14 ( .A(n40), .B(n41), .C(n42), .Y(n38) );
  OAI21X1 U16 ( .A(paddr[1]), .B(n40), .C(pwrite), .Y(n42) );
  OAI22X1 U18 ( .A(n43), .B(n44), .C(n45), .D(n46), .Y(next_temp_data_size[3])
         );
  OAI22X1 U44 ( .A(n43), .B(n47), .C(n45), .D(n48), .Y(next_temp_data_size[2])
         );
  OAI22X1 U45 ( .A(n43), .B(n49), .C(n45), .D(n50), .Y(next_temp_data_size[1])
         );
  INVX1 U46 ( .A(pwdata[1]), .Y(n49) );
  OAI22X1 U47 ( .A(n43), .B(n51), .C(n45), .D(n52), .Y(next_temp_data_size[0])
         );
  INVX1 U48 ( .A(n43), .Y(n45) );
  INVX1 U49 ( .A(pwdata[0]), .Y(n51) );
  NAND3X1 U50 ( .A(n41), .B(n53), .C(n54), .Y(n43) );
  NOR2X1 U51 ( .A(n40), .B(n55), .Y(n54) );
  INVX1 U52 ( .A(paddr[1]), .Y(n53) );
  NAND2X1 U53 ( .A(n56), .B(n57), .Y(next_prdata[7]) );
  AOI22X1 U54 ( .A(bit_period_13_8[7]), .B(n58), .C(bit_period[7]), .D(n59), 
        .Y(n57) );
  AOI22X1 U55 ( .A(prdata[7]), .B(n60), .C(real_rx_data[7]), .D(n121), .Y(n56)
         );
  NAND2X1 U56 ( .A(n61), .B(n62), .Y(next_prdata[6]) );
  AOI22X1 U57 ( .A(bit_period_13_8[6]), .B(n58), .C(bit_period[6]), .D(n59), 
        .Y(n62) );
  AOI22X1 U58 ( .A(prdata[6]), .B(n60), .C(real_rx_data[6]), .D(n121), .Y(n61)
         );
  NAND2X1 U59 ( .A(n63), .B(n64), .Y(next_prdata[5]) );
  AOI22X1 U60 ( .A(bit_period[13]), .B(n58), .C(bit_period[5]), .D(n59), .Y(
        n64) );
  AOI22X1 U61 ( .A(prdata[5]), .B(n60), .C(real_rx_data[5]), .D(n121), .Y(n63)
         );
  NAND2X1 U62 ( .A(n65), .B(n66), .Y(next_prdata[4]) );
  AOI22X1 U63 ( .A(bit_period[12]), .B(n58), .C(bit_period[4]), .D(n59), .Y(
        n66) );
  AOI22X1 U64 ( .A(prdata[4]), .B(n60), .C(real_rx_data[4]), .D(n121), .Y(n65)
         );
  NAND2X1 U65 ( .A(n67), .B(n68), .Y(next_prdata[3]) );
  AOI21X1 U66 ( .A(bit_period[3]), .B(n59), .C(n69), .Y(n68) );
  OAI22X1 U67 ( .A(n70), .B(n71), .C(n46), .D(n72), .Y(n69) );
  INVX1 U68 ( .A(data_size[3]), .Y(n46) );
  AOI22X1 U69 ( .A(prdata[3]), .B(n60), .C(real_rx_data[3]), .D(n121), .Y(n67)
         );
  NAND2X1 U70 ( .A(n73), .B(n74), .Y(next_prdata[2]) );
  AOI21X1 U71 ( .A(bit_period[2]), .B(n59), .C(n75), .Y(n74) );
  OAI22X1 U72 ( .A(n70), .B(n76), .C(n48), .D(n72), .Y(n75) );
  INVX1 U73 ( .A(data_size[2]), .Y(n48) );
  AOI22X1 U74 ( .A(prdata[2]), .B(n60), .C(real_rx_data[2]), .D(n121), .Y(n73)
         );
  NAND3X1 U75 ( .A(n77), .B(n78), .C(n79), .Y(next_prdata[1]) );
  AOI21X1 U76 ( .A(bit_period[9]), .B(n58), .C(n80), .Y(n79) );
  OAI21X1 U77 ( .A(n50), .B(n72), .C(n81), .Y(n80) );
  NAND3X1 U78 ( .A(overrun_error), .B(n82), .C(n83), .Y(n81) );
  NOR2X1 U79 ( .A(n84), .B(n85), .Y(n83) );
  INVX1 U80 ( .A(data_size[1]), .Y(n50) );
  NAND2X1 U81 ( .A(real_rx_data[1]), .B(n121), .Y(n78) );
  AOI22X1 U82 ( .A(bit_period[1]), .B(n59), .C(prdata[1]), .D(n60), .Y(n77) );
  NAND3X1 U83 ( .A(n86), .B(n87), .C(n88), .Y(next_prdata[0]) );
  AOI21X1 U84 ( .A(bit_period[8]), .B(n58), .C(n89), .Y(n88) );
  OAI22X1 U85 ( .A(n52), .B(n72), .C(n90), .D(n91), .Y(n89) );
  NAND2X1 U86 ( .A(n82), .B(n92), .Y(n91) );
  MUX2X1 U87 ( .B(n93), .A(data_ready), .S(n84), .Y(n90) );
  NOR2X1 U88 ( .A(n94), .B(overrun_error), .Y(n93) );
  INVX1 U89 ( .A(framing_error), .Y(n94) );
  NAND3X1 U90 ( .A(n92), .B(n95), .C(n84), .Y(n72) );
  INVX1 U91 ( .A(data_size[0]), .Y(n52) );
  INVX1 U92 ( .A(n70), .Y(n58) );
  NAND3X1 U93 ( .A(n85), .B(n96), .C(n82), .Y(n70) );
  NAND2X1 U94 ( .A(real_rx_data[0]), .B(n121), .Y(n87) );
  AOI22X1 U95 ( .A(bit_period[0]), .B(n59), .C(prdata[0]), .D(n60), .Y(n86) );
  INVX1 U96 ( .A(n97), .Y(n60) );
  NAND3X1 U97 ( .A(n95), .B(n96), .C(n92), .Y(n97) );
  INVX1 U98 ( .A(n98), .Y(n59) );
  NAND3X1 U99 ( .A(n82), .B(n85), .C(n84), .Y(n98) );
  INVX1 U100 ( .A(n95), .Y(n82) );
  INVX1 U101 ( .A(n99), .Y(next_bit_period_7_0[7]) );
  AOI22X1 U102 ( .A(n100), .B(pwdata[7]), .C(n101), .D(bit_period[7]), .Y(n99)
         );
  INVX1 U103 ( .A(n102), .Y(next_bit_period_7_0[6]) );
  AOI22X1 U104 ( .A(n100), .B(pwdata[6]), .C(n101), .D(bit_period[6]), .Y(n102) );
  INVX1 U105 ( .A(n103), .Y(next_bit_period_7_0[5]) );
  AOI22X1 U106 ( .A(n100), .B(pwdata[5]), .C(n101), .D(bit_period[5]), .Y(n103) );
  INVX1 U107 ( .A(n104), .Y(next_bit_period_7_0[4]) );
  AOI22X1 U108 ( .A(n100), .B(pwdata[4]), .C(n101), .D(bit_period[4]), .Y(n104) );
  OAI22X1 U109 ( .A(n44), .B(n101), .C(n100), .D(n105), .Y(
        next_bit_period_7_0[3]) );
  INVX1 U110 ( .A(bit_period[3]), .Y(n105) );
  OAI22X1 U111 ( .A(n47), .B(n101), .C(n100), .D(n106), .Y(
        next_bit_period_7_0[2]) );
  INVX1 U112 ( .A(bit_period[2]), .Y(n106) );
  INVX1 U113 ( .A(n107), .Y(next_bit_period_7_0[1]) );
  AOI22X1 U114 ( .A(pwdata[1]), .B(n100), .C(n101), .D(bit_period[1]), .Y(n107) );
  INVX1 U115 ( .A(n108), .Y(next_bit_period_7_0[0]) );
  AOI22X1 U116 ( .A(pwdata[0]), .B(n100), .C(n101), .D(bit_period[0]), .Y(n108) );
  INVX1 U117 ( .A(n101), .Y(n100) );
  NAND2X1 U118 ( .A(n109), .B(n41), .Y(n101) );
  INVX1 U119 ( .A(n110), .Y(next_bit_period_13_8[7]) );
  AOI22X1 U120 ( .A(pwdata[7]), .B(n111), .C(n112), .D(bit_period_13_8[7]), 
        .Y(n110) );
  INVX1 U121 ( .A(n113), .Y(next_bit_period_13_8[6]) );
  AOI22X1 U122 ( .A(pwdata[6]), .B(n111), .C(n112), .D(bit_period_13_8[6]), 
        .Y(n113) );
  INVX1 U123 ( .A(n114), .Y(next_bit_period_13_8[5]) );
  AOI22X1 U124 ( .A(pwdata[5]), .B(n111), .C(n112), .D(bit_period[13]), .Y(
        n114) );
  INVX1 U125 ( .A(n115), .Y(next_bit_period_13_8[4]) );
  AOI22X1 U126 ( .A(pwdata[4]), .B(n111), .C(n112), .D(bit_period[12]), .Y(
        n115) );
  OAI22X1 U127 ( .A(n44), .B(n112), .C(n111), .D(n71), .Y(
        next_bit_period_13_8[3]) );
  INVX1 U128 ( .A(bit_period[11]), .Y(n71) );
  INVX1 U129 ( .A(pwdata[3]), .Y(n44) );
  OAI22X1 U130 ( .A(n47), .B(n112), .C(n111), .D(n76), .Y(
        next_bit_period_13_8[2]) );
  INVX1 U131 ( .A(bit_period[10]), .Y(n76) );
  INVX1 U132 ( .A(pwdata[2]), .Y(n47) );
  INVX1 U133 ( .A(n116), .Y(next_bit_period_13_8[1]) );
  AOI22X1 U134 ( .A(pwdata[1]), .B(n111), .C(n112), .D(bit_period[9]), .Y(n116) );
  INVX1 U135 ( .A(n117), .Y(next_bit_period_13_8[0]) );
  AOI22X1 U136 ( .A(pwdata[0]), .B(n111), .C(n112), .D(bit_period[8]), .Y(n117) );
  INVX1 U137 ( .A(n112), .Y(n111) );
  NAND2X1 U138 ( .A(n109), .B(paddr[0]), .Y(n112) );
  NOR2X1 U139 ( .A(n39), .B(n55), .Y(n109) );
  NAND3X1 U140 ( .A(penable), .B(pwrite), .C(psel), .Y(n55) );
  NAND2X1 U141 ( .A(paddr[1]), .B(n40), .Y(n39) );
  INVX1 U142 ( .A(n118), .Y(n121) );
  NAND3X1 U143 ( .A(n85), .B(n95), .C(n84), .Y(n118) );
  INVX1 U144 ( .A(n96), .Y(n84) );
  NAND2X1 U145 ( .A(n119), .B(n41), .Y(n96) );
  INVX1 U146 ( .A(paddr[0]), .Y(n41) );
  NAND2X1 U147 ( .A(n119), .B(n40), .Y(n95) );
  INVX1 U148 ( .A(paddr[2]), .Y(n40) );
  INVX1 U149 ( .A(n92), .Y(n85) );
  NAND2X1 U150 ( .A(n119), .B(paddr[1]), .Y(n92) );
  NOR2X1 U151 ( .A(n120), .B(pwrite), .Y(n119) );
  INVX1 U152 ( .A(psel), .Y(n120) );
endmodule


module apb_uart_rx ( clk, n_rst, serial_in, psel, paddr, penable, pwrite, 
        pwdata, prdata, pslverr );
  input [2:0] paddr;
  input [7:0] pwdata;
  output [7:0] prdata;
  input clk, n_rst, serial_in, psel, penable, pwrite;
  output pslverr;
  wire   data_read, data_ready, overrun_error, framing_error;
  wire   [7:0] rx_data;
  wire   [3:0] data_size;
  wire   [13:0] bit_period;

  rcv_block rcv_block1 ( .clk(clk), .n_rst(n_rst), .serial_in(serial_in), 
        .data_read(data_read), .rx_data(rx_data), .data_ready(data_ready), 
        .overrun_error(overrun_error), .framing_error(framing_error), 
        .data_size(data_size), .data_period(bit_period) );
  apb_slave apb_slave1 ( .clk(clk), .n_rst(n_rst), .rx_data(rx_data), 
        .data_ready(data_ready), .overrun_error(overrun_error), 
        .framing_error(framing_error), .psel(psel), .paddr(paddr), .penable(
        penable), .pwrite(pwrite), .pwdata(pwdata), .data_read(data_read), 
        .prdata(prdata), .pslverr(pslverr), .data_size(data_size), 
        .bit_period(bit_period) );
endmodule

