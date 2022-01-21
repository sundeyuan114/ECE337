// $Id: $
// File name:   sensor_d.sv
// Created:     1/21/2022
// Author:      Deyuan Sun
// Lab Section: 337-06
// Version:     1.0  Initial Design Entry
// Description: dataflow lab2 error sensor

module sensor_d(

	input logic [3:0] sensors,
	output logic error	

);

reg int_and1, int_and2;

//AND2X1 A1 (.Y(int_and1) ,.A(sensors[3]) ,.B(sensors[1]));
//AND2X1 A2 (.Y(int_and2) ,.A(sensors[2]) ,.B(sensors[1]));
//OR2X1 A3 (.Y(or1) ,.A(int_and1) ,.B(int_and2) );
//OR2X1 A4 (.Y(error) ,.A(sensors[0]) ,.B(or1));

assign error = sensors[0] | (sensors[3] & sensors[1]) | (sensors[2] & sensors[1]);





endmodule
