// $Id: $
// File name:   mealy.sv
// Created:     2/17/2022
// Author:      Deyuan Sun
// Lab Section: 337-06
// Version:     1.0  Initial Design Entry
// Description: mealy.

module mealy (
    input logic clk,
    input logic n_rst,
    input logic i,
    output logic o
);
typedef enum logic [1:0] {IDLE, STATE_1, STATE_11, STATE_110} stateType;
logic [1:0] state;
logic [1:0] next_state;

    always_ff @( posedge clk, negedge n_rst ) begin : blockName
        if (!n_rst) begin
            state <= IDLE;
        end
        else begin
            state <= next_state;
        end
    end

    always_comb begin : nextstatelogic
        next_state = state;
        case(state)
        IDLE: next_state = i ? STATE_1 : IDLE;
        STATE_1: next_state = i? STATE_11 : IDLE;
        STATE_11: next_state = i? STATE_11 : STATE_110;
        STATE_110: next_state = i? STATE_1 : IDLE;
        endcase
    end

    assign o = ((state == STATE_110) && (i == 1));
endmodule