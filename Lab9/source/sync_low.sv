// $Id: $
// File name:   sync_low.sv
// Created:     2/4/2022
// Author:      Deyuan Sun
// Lab Section: 337-06
// Version:     1.0  Initial Design Entry
// Description: 2ff sync from postlab1

module sync_low(
    input logic clk,
    input logic n_rst,
    input logic async_in,
    output logic sync_out
);
logic temp;

    always_ff @ (posedge clk, negedge n_rst)
    begin
        if (n_rst == 1'b0) begin
            temp <= 1'b0;
        end
        else begin
            temp <= async_in;
        end
    end

    always_ff @ (posedge clk, negedge n_rst)
    begin
        if (n_rst == 1'b0) begin
            sync_out <= 1'b0;
        end
        else begin
            sync_out <= temp;
        end
    end


endmodule