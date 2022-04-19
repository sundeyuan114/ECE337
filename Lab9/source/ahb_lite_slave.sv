module ahb_lite_slave (
    input logic clk,
    input logic n_rst,

    output logic [15:0] sample_data,
    output logic data_ready,
    output logic new_coefficient_set,

    input logic [1:0] coefficient_num,

    output logic [15:0] fir_coefficient,

    input logic modwait,
    input logic [15:0] fir_out,
    input logic err,
    input logic hsel,
    input logic [3:0] haddr,
    input logic hsize,
    input logic [1:0] htrans,
    input logic hwrite,
    input logic [15:0] hwdata,
    output logic [15:0] hrdata,
    output logic hresp,

    input logic coef_clear
);

localparam IDLE = 2'd0;
localparam DELAY_BURST = 2'd1; // burst not used
localparam NON_SEQ = 2'd2;
localparam SEQ_BURST = 2'd3;   // burst not used

//mapping regs
logic fb_hsel; // for feedback
logic [1:0] fb_htrans;
logic [3:0] fb_haddr;
logic fb_hsize;
logic fb_hwrite;

//mux regs
logic [15:0] next_sample_data;
    
logic [15:0] f0_reg;
logic [15:0] f1_reg;
logic [15:0] f2_reg;
logic [15:0] f3_reg;

logic [15:0] next_f0;
logic [15:0] next_f1;
logic [15:0] next_f2;
logic [15:0] next_f3;

logic [7:0] new_coef;
logic [7:0] next_new_coef;

logic next_data_ready;

logic [15:0] status_reg;
// Value of ’0’ → FIR Filter is idle,
// Value of ’1’ for bit-0 → FIR Filter is busy,
// Value of ’1’ for bit-8 → FIR Filter encountered an error
assign busy = modwait || new_coefficient_set;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//flip-flops
always_ff @(posedge clk, negedge n_rst ) begin : combMux_flipflops
    if (n_rst == 0) begin
        fb_hsel <= '0;
        fb_htrans <= '0;
        fb_haddr <= '0;
        fb_hsize <= '0;
        fb_hwrite <= '0;
    end
    else begin
        fb_hsel <= hsel;
        fb_htrans <= htrans;
        fb_haddr <= haddr;
        fb_hsize <= hsize;
        fb_hwrite <= hwrite;
    end
end

always_ff @(posedge clk, negedge n_rst ) begin : memoryMux
    if (n_rst == 0) begin
        sample_data <= '0;
        f0_reg <= '0;
        f1_reg <= '0;
        f2_reg <= '0;
        f3_reg <= '0;
        new_coef <= '0;
        data_ready <= 0;
    end
    else begin
        sample_data <= next_sample_data;
        f0_reg <= next_f0;
        f1_reg <= next_f1;
        f2_reg <= next_f2;
        f3_reg <= next_f3;
        new_coef <= next_new_coef;
        data_ready <= next_data_ready;
    end
end
///////////////////////////////////////////////////////////////////////////////////////////////////////
//prdata always_comb
always_comb begin : writeMux
    //prevent latchs
    next_data_ready = data_ready;       //slave -> FIR Filter
    next_sample_data = sample_data;     //0x4 2byte
    next_f0 = f0_reg;                   //0x6 2byte
    next_f1 = f1_reg;                   //0x8 2byte
    next_f2 = f2_reg;                   //0xA 2byte
    next_f3 = f3_reg;                   //0xC 2byte
    next_new_coef = new_coef;           //0xE 1byte
    new_coefficient_set = new_coef[0];
    //default for all 6 regs
    if (fb_hsel && fb_hwrite && fb_htrans == NON_SEQ)begin
        if(fb_hsize == 0) begin// write 1 byte of data, 8 bit of data
            case (fb_haddr)
                4'h4: next_sample_data = {sample_data[15:8], hwdata[7:0]};
                4'h5: next_sample_data = {hwdata[7:0], sample_data[7:0]};

                4'h6: next_f0 = {f0_reg[15:8], hwdata[7:0]};
                4'h7: next_f0 = {hwdata[7:0], f0_reg[7:0]};

                4'h8: next_f1 = {f1_reg[15:8], hwdata[7:0]};
                4'h9: next_f1 = {hwdata[7:0], f1_reg[7:0]};

                4'hA: next_f2 = {f2_reg[15:8], hwdata[7:0]};
                4'hB: next_f2 = {hwdata[7:0], f2_reg[7:0]};

                4'hC: next_f3 = {f3_reg[15:8], hwdata[7:0]};
                4'hD: next_f3 = {hwdata[7:0], f3_reg[7:0]};

                4'hE: next_new_coef = hwdata[7:0];
            endcase
        end
        else begin            // write 2 bytes of data, 16 bits
            case (fb_haddr)
                4'h4: next_sample_data = hwdata;
                4'h5: next_sample_data = hwdata;

                4'h6: next_f0 = hwdata;
                4'h7: next_f0 = hwdata;

                4'h8: next_f1 = hwdata;
                4'h9: next_f1 = hwdata;

                4'hA: next_f2 = hwdata;
                4'hB: next_f2 = hwdata;

                4'hC: next_f3 = hwdata;
                4'hD: next_f3 = hwdata;

                4'hE: next_new_coef = hwdata[7:0]; 
            endcase
        end
    end

    // coef load
    if (coef_clear) begin
        next_new_coef = '0;
    end
    case (coefficient_num)
        2'h0: fir_coefficient = f0_reg;
        2'h1: fir_coefficient = f1_reg;
        2'h2: fir_coefficient = f2_reg;
        2'h3: fir_coefficient = f3_reg;
    endcase

    // next_data_read
    if (modwait) begin
        next_data_ready = '0;
    end // new sample reg, address 0x4(4'b0100) or 0x5(4'b0101)
    else if ((fb_haddr[3:1] == 3'b010) && fb_hwrite && fb_hsel && fb_htrans == NON_SEQ) begin
        next_data_ready = 1;
    end
end

//err
always_comb begin : errlogic
    hresp = 0;
    if (haddr == 4'hf) begin
        hresp = 1;
    end
    if (hwrite && (haddr <= 4'h3)) begin
        hresp = 1;
    end
end

//read

always_comb begin
    hrdata = '0;
    if(fb_hsel && ~fb_hwrite && fb_htrans == NON_SEQ) begin
        if (fb_hsize == 0) begin // 1 byte 8 bit, half of most register 
            case(fb_haddr)
                4'h0: hrdata = {8'd0, status_reg[7:0]};
                4'h1: hrdata = {8'd0, status_reg[15:8]};

                4'h2: hrdata = {8'd0, fir_out[7:0]};
                4'h3: hrdata = {8'd0, fir_out[15:8]};

                4'h4: hrdata = {8'd0, sample_data[7:0]};
                4'h5: hrdata = {8'd0, sample_data[15:8]};

                4'h6: hrdata = {8'd0, f0_reg[7:0]};
                4'h7: hrdata = {8'd0, f0_reg[15:8]};

                4'h8: hrdata = {8'd0, f1_reg[7:0]};
                4'h9: hrdata = {8'd0, f1_reg[15:8]};

                4'hA: hrdata = {8'd0, f2_reg[7:0]};
                4'hB: hrdata = {8'd0, f2_reg[15:8]};

                4'hC: hrdata = {8'd0, f3_reg[7:0]};
                4'hD: hrdata = {8'd0, f3_reg[15:8]};

                4'hE: hrdata = new_coef[7:0];
                
                4'hF: hrdata = '0;

                default: hrdata = '0;
            endcase 
        end
        else begin
            case(fb_haddr)
                4'h0: hrdata = status_reg;
                4'h1: hrdata = status_reg;

                4'h2: hrdata = fir_out;
                4'h3: hrdata = fir_out;

                4'h4: hrdata = sample_data;
                4'h5: hrdata = sample_data;

                4'h6: hrdata = f0_reg;
                4'h7: hrdata = f0_reg;

                4'h8: hrdata = f1_reg;
                4'h9: hrdata = f1_reg;

                4'hA: hrdata = f2_reg;
                4'hB: hrdata = f2_reg;

                4'hC: hrdata = f3_reg;
                4'hD: hrdata = f3_reg;

                4'hE: hrdata = {8'd0, new_coef[7:0]};
                
                4'hF: hrdata = '0;

                default: hrdata = '0;
            endcase
        end
    end
end

assign status_reg = {7'b0, err, 7'b0, busy};

endmodule