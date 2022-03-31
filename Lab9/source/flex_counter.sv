// $Id: $
// File name:   flex_counter.sv
// Created:     2/10/2022
// Author:      Deyuan Sun
// Lab Section: 337-06
// Version:     1.0  Initial Design Entry
// Description: .

module flex_counter 
#(
    parameter NUM_CNT_BITS = 4
)
(
    input logic clk,
    input logic n_rst,
    input logic clear,
    input logic count_enable,
    input logic [NUM_CNT_BITS - 1 : 0 ]rollover_val,
    output logic [NUM_CNT_BITS - 1 : 0 ]count_out,
    output logic rollover_flag
);

logic [NUM_CNT_BITS - 1 : 0 ] next_count;
logic next_flag;


always_comb begin
    next_count = count_out;
    next_flag = rollover_flag;
    
    if(clear) begin
        next_count = 0;
        next_flag = 0;
    end
    else if (count_enable) begin
        if(count_out == rollover_val - 1) begin
            next_flag = 1;
            next_count = count_out + 1;
        end
        else if(count_out < rollover_val) begin
            next_count = count_out + 1;
            next_flag = 0;
        end
        else begin
            next_count = 1;
            next_flag = 0;
        end
    end
end

always_ff @(posedge clk , negedge n_rst) begin
    if (n_rst == 1'b0) begin
        count_out <= 1'b0;
        rollover_flag <= 1'b0;
    end
    else begin
        count_out <= next_count;
        rollover_flag <= next_flag;
    end
end
endmodule