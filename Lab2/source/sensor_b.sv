// $Id: $
// File name:   sensor_b.sv
// Created:     1/21/2022
// Author:      Deyuan Sun
// Lab Section: 337-06
// Version:     1.0  Initial Design Entry

module sensor_b(

	input logic [3:0] sensors,
	output logic error	

);


always_comb begin
	error = sensors[0] | (sensors[3] & sensors[1]) | (sensors[2] & sensors[1]);
end







endmodule
