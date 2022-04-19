
// 4'd0: accumulate

// 4'd1: oldest data

// 4'd2: second oldest data

// 4'd3: store new data in a register

// 4'd4: coef with 4'd1

// 4'd5: coef with 4'd2

// 4'd6: result from MUL for coef * sample

// 4'd7: coef

// 4'd8: coef

// 4'd9: 3 oldest data

// 4'd10: newest data

module controller(
    input logic clk,
    input logic n_rst,
    input logic dr,
    input logic lc,
    input logic overflow,

    output logic cnt_up,
    output logic clear,
    output logic modwait,
    output logic [2:0] op,
    output logic [3:0] src1,
    output logic [3:0] src2,
    output logic [3:0] dest,
    output logic err
);


    localparam NOP = 3'b000;
    localparam COPY = 3'b001;
    localparam LOAD1 = 3'b010;
    localparam LOAD2 = 3'b011;
    localparam ADD = 3'b100;
    localparam SUB = 3'b101;
    localparam MUL = 3'b110;


    typedef enum logic [4:0] { IDLE, load_c1, wait1, 
                                     load_c2, wait2,
                                     load_c3, wait3,
                                     load_c4, 
                store, zero, sort1, sort2, sort3, sort4,
                mul1, add1, mul2, sub1, mul3, add2, mul4, sub2, eidle
                } stateType; // total 23 states

    logic next_modwait;
    stateType  state;
    stateType  next_state;

// flip-flop
always_ff @( posedge clk, negedge n_rst ) begin : flipflop
    if(n_rst == 0) begin
        state <= IDLE;
        modwait <= 0;
    end
    else begin
        state <= next_state;
        modwait <= next_modwait;
    end
end

// next state logic
always_comb begin : next_state_logic
    next_state = state;
    next_modwait = 0;
    case(state)
        IDLE: begin        
            if (lc) begin 
                next_modwait = 1;
                next_state = load_c1;
            end
            else if (dr) begin
                next_modwait = 1;
                next_state = store;
            end
        end
        load_c1: begin                      //c1
            next_state = wait1;
        end
        wait1: begin
            if (lc) begin
                next_state = load_c2;   
                next_modwait = 1;
            end
        end
        load_c2: begin                      //c2
            next_state = wait2;
        end
        wait2: begin
            if (lc) begin
                next_state = load_c3;
                next_modwait = 1;
            end
        end
        load_c3: begin                      //c3
            next_state = wait3;
        end
        wait3: begin
            if (lc) begin
                next_state = load_c4;
                next_modwait = 1;
            end
        end
        load_c4: begin                      //c4
            next_state = IDLE;
        end
//////////////////////////////////// finish load
        store: begin
            next_state = (!dr) ? eidle : zero; 
            next_modwait = (!dr) ? 0 : 1; 
        end
        zero : begin
            next_state = sort1; 
            next_modwait = 1; 
        end
        sort1: begin
            next_state = sort2;
            next_modwait = 1; 
        end
        sort2: begin
            next_state = sort3;
            next_modwait = 1; 
        end
        sort3: begin 
            next_state = sort4;
            next_modwait = 1;
        end
        sort4: begin 
            next_state = mul1;
            next_modwait = 1;
        end
        //////////////////////////////////////////////
        mul1 : begin
            next_state = overflow ? eidle : add1;
            next_modwait = overflow ? 0 : 1;
        end
        add1 : begin 
            next_state = overflow ? eidle : mul2;
            next_modwait = overflow ? 0 : 1;
        end
        mul2 : begin
            next_state = overflow ? eidle : sub1;
            next_modwait = overflow ? 0 : 1;
        end
        sub1 : begin
            next_state = overflow ? eidle : mul3;
            next_modwait = overflow ? 0 : 1;
        end
        mul3 : begin
            next_state = overflow ? eidle : add2;
            next_modwait = overflow ? 0 : 1;
        end
        add2 : begin
            next_state = overflow ? eidle : mul4;
            next_modwait = overflow ? 0 : 1;
        end
        mul4 : begin
            next_state = overflow ? eidle : sub2;
            next_modwait = overflow ? 0 : 1;
        end
        sub2 : begin 
            next_state = overflow ? eidle : IDLE;
            next_modwait = 0; ///////////////////////////////
        end

        eidle: begin
            if (lc) begin
                next_state = load_c1;
                next_modwait = 1;
            end
            else if (dr) begin
                next_state = store;
                next_modwait = 1;
            end
        end
    endcase    
end
// output logic
logic [3:0] temp;

assign cnt_up = temp[3];
assign clear = temp[2];
assign err = temp[0];

always_comb begin
    temp = '0;

    op = NOP;
    src1 = '0;
    src2 = '0;
    dest = '0;

    case(state)
        load_c1: begin
            op = LOAD2;
            dest = 4'd4;
            temp = 4'b0110;
        end
        load_c2: begin
            op = LOAD2;
            dest = 4'd5;
            temp = 4'b0110;
        end
        load_c3: begin
            op = LOAD2;
            dest = 4'd7;
            temp = 4'b0110;
        end
        load_c4: begin
            op = LOAD2;
            dest = 4'd8;
            temp = 4'b0110;
        end
        store  : begin        // count up right here
            op = LOAD1;
            dest = 4'd3;
            temp = 4'b1010;
        end
        zero   : begin
            src1 = 4'd1;
            src2 = 4'd1;
            dest = 4'd0;
            op = SUB;
            temp = 4'b0010;
        end
        sort1   : begin
            src1 = 4'd2;
            dest = 4'd1;
            op = COPY;
            temp = 4'b0010;
        end
        sort2   : begin
            src1 = 4'd9;
            dest = 4'd2;
            op = COPY;
            temp = 4'b0010;
        end
        sort3   : begin
            src1 = 4'd10;
            dest = 4'd9;
            op = COPY;
            temp = 4'b0010;
        end
        sort4   : begin
            src1 = 4'd3;
            dest = 4'd10;
            op = COPY;
            temp = 4'b0010;
        end

        mul1   : begin
            src1 = 4'd1;
            src2 = 4'd4;
            dest = 4'd6;
            op = MUL;
            temp = 4'b0010;
        end
        add1   : begin
            src1 = 4'd0;
            src2 = 4'd6;
            dest = 4'd0;
            op = ADD;
            temp = 4'b0010;
        end
        mul2   : begin
            src1 = 4'd2;
            src2 = 4'd5;
            dest = 4'd6;
            op = MUL;
            temp = 4'b0010;
        end
        sub1   : begin
            src1 = 4'd0;
            src2 = 4'd6;
            dest = 4'd0;
            op = SUB;
            temp = 4'b0010;
        end
        mul3   : begin
            src1 = 4'd7;
            src2 = 4'd9;
            dest = 4'd6;
            op = MUL;
            temp = 4'b0010;
        end
        add2   : begin
            src1 = 4'd0;
            src2 = 4'd6;
            dest = 4'd0;
            op = ADD;
            temp = 4'b0010;
        end
        mul4   : begin
            src1 = 4'd8;
            src2 = 4'd10;
            dest = 4'd6;
            op = MUL;
            temp = 4'b0010;
        end
        sub2   : begin
            src1 = 4'd0;
            src2 = 4'd6;
            dest = 4'd0;
            op = SUB;
            temp = 4'b0010;
        end

        eidle   : begin
            temp = 4'b0001;
        end

    endcase
end 

  
endmodule