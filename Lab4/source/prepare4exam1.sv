// $Id: $
// File name:   prepare4exam1.sv
// Created:     2/14/2022
// Author:      Deyuan Sun
// Lab Section: 337-06
// Version:     1.0  Initial Design Entry
// Description: yeyeyeyeye gimme 100 on exam

module test1(
input reg [3:0][7:0] pack,
output reg temp
);

assign pack = '{8'h33,8'h22,8'h11,8'hEE};
assign temp = pack[1][0];

endmodule
