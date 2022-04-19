module coefficient_loader (
    input logic clk,
    input logic n_reset,
    input logic new_coefficient_set,
    input logic modwait,

    output logic load_coeff,
    output logic [1:0] coefficient_num,
    output logic coef_clear
);
typedef enum logic [3:0] { IDLE, LOAD0, WAIT0, LOAD1, WAIT1, LOAD2, WAIT2, LOAD3, WAIT3, FINISH} stateType;

stateType state;
stateType next_state;

// ff
always_ff @( posedge clk, negedge n_reset ) begin : ff
    if (n_reset == 0) begin
        state = IDLE;
    end
    else begin
        state = next_state;
    end
end

always_comb begin
    next_state = state;
    coef_clear = '0;
    case(state)
        IDLE   : begin
            next_state = new_coefficient_set ? LOAD0 : IDLE;
            load_coeff = 1'd0;
            coefficient_num = 2'd0;
        end
        LOAD0  :begin
            next_state = WAIT0;
            load_coeff = 1'd1;
            coefficient_num = 2'd0;
        end
        WAIT0  :begin
            next_state = modwait ? LOAD1 : IDLE;
            load_coeff = 1'd0;
            coefficient_num = 2'd0;
        end
        LOAD1  :begin
            next_state = WAIT1;
            load_coeff = 1'd1;
            coefficient_num = 2'd1;
        end
        WAIT1  :begin
            next_state = modwait ? LOAD2 : IDLE;
            load_coeff = 1'd0;
            coefficient_num = 2'd1;
        end
        LOAD2  :begin
            next_state = WAIT2;
            load_coeff = 1'd1;
            coefficient_num = 2'd2;
        end
        WAIT2  :begin
            next_state = modwait ? LOAD3 : IDLE;
            load_coeff = 1'd0;
            coefficient_num = 2'd2;
        end
        LOAD3  :begin
            next_state = WAIT3;
            load_coeff = 1'd1;
            coefficient_num = 2'd3;
        end
        WAIT3  :begin
            next_state = modwait ? FINISH : IDLE;
            load_coeff = 1'd0;
            coefficient_num = 2'd3;
        end
        FINISH :begin
            next_state = IDLE;
            load_coeff = 1'd0;
            coefficient_num = 2'd0;

            coef_clear = 1;
        end
        default : begin
            next_state = IDLE;
            load_coeff = 1'd0;
            coefficient_num = 2'd0;
        end

    endcase
end

endmodule