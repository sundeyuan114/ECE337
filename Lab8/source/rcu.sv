module rcu (
    input logic clk,
    input logic n_rst,
    input logic new_packet_detected,
    input logic packet_done,
    input logic framing_error,
    output logic sbc_clear,
    output logic sbc_enable,
    output logic load_buffer,
    output logic enable_timer
);


typedef enum logic [2:0] { IDLE, 
first_rec, then_rec, check_valid, wait_err, success} stateType;

stateType next_state;
stateType state;

//flip-flop
always_ff @( posedge clk, negedge n_rst ) begin 
    if(n_rst == 0) begin
        state <= IDLE;
    end
    else begin
        state <= next_state;
    end
end

//next_state logic
always_comb begin 
    next_state = state;
    case (state)
        IDLE: begin
            if(new_packet_detected) begin
                next_state = first_rec;
            end
        end
        first_rec: begin
            next_state = then_rec;
        end
        then_rec: begin
            if(packet_done) begin
                next_state = check_valid;
            end
        end
        check_valid: begin
            next_state = wait_err;
        end
        wait_err: begin
            if (framing_error) begin
                next_state = IDLE;
            end
            else begin
                next_state = success;
            end
        end
        success: begin
            next_state = IDLE;
        end
    endcase
end
// output logic
always_comb begin
    sbc_clear = 0;
    sbc_enable = 0;
    load_buffer = 0;
    enable_timer = 0;
    case(state) 
        IDLE: begin
            sbc_clear = 0;
            sbc_enable = 0;
            load_buffer = 0;
            enable_timer = 0;
        end
        first_rec: begin
            sbc_clear = 1;
            sbc_enable = 0;
            load_buffer = 0;
            enable_timer = 1;
        end
        then_rec: begin
            sbc_clear = 0;
            sbc_enable = 0;
            load_buffer = 0;
            enable_timer = 1;
        end
        check_valid: begin
            sbc_clear = 0;
            sbc_enable = 1;
            load_buffer = 0;
            enable_timer = 0;
        end
        wait_err: begin
            sbc_clear = 0;
            sbc_enable = 0;
            load_buffer = 0;
            enable_timer = 0;
        end
        success: begin
            sbc_clear = 0;
            sbc_enable = 0;
            load_buffer = 1;
            enable_timer = 0;
        end
    endcase
end

endmodule