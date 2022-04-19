/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Fri Feb  4 12:21:54 2022
/////////////////////////////////////////////////////////////


module sync_low ( clk, n_rst, async_in, sync_out );
  input clk, n_rst, async_in;
  output sync_out;
  wire   temp;

  DFFSR temp_reg ( .D(async_in), .CLK(clk), .R(n_rst), .S(1'b1), .Q(temp) );
  DFFSR sync_out_reg ( .D(temp), .CLK(clk), .R(n_rst), .S(1'b1), .Q(sync_out)
         );
endmodule

