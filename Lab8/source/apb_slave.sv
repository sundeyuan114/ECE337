//change color
module apb_slave (
    input logic clk,
    input logic n_rst,
    input logic [7:0] rx_data,
    input logic data_ready,
    input logic overrun_error,
    input logic framing_error,
    input logic psel,
    input logic [2:0] paddr,
    input logic penable,
    input logic pwrite,
    input logic [7:0] pwdata,
    output logic data_read,
    output logic [7:0] prdata,
    output logic pslverr,
    output logic [3:0] data_size,
    output logic [13:0] bit_period
);

logic [7:0] next_prdata;

logic [7:0] real_rx_data;

logic [7:0] next_data_read;

logic [7:0] bit_period_7_0;
logic [7:0] next_bit_period_7_0;

logic [7:0] bit_period_13_8;
logic [7:0] next_bit_period_13_8;
// logic [5:0] bit_period_13_8;
// logic [5:0] next_bit_period_13_8;

logic [7:0] temp_data_size;
logic [7:0] next_temp_data_size;

logic [2:0] write_select;
logic [2:0] read_select;

logic [7:0] input_error;
// ERROR PART SHOULD BE CONNECT TO ADDR 0x2 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!============------------=========  
///

always_ff @( posedge clk, negedge n_rst ) begin : prdata_reg
    if (!n_rst) begin
        prdata = '0;
    end
    else begin
        prdata = next_prdata;
    end
end

// This is the register corresponding to the address 0x6 register, RTL DIAGRAM IS WRONG, DON't USE 0x5!
always_ff @( posedge clk, negedge n_rst ) begin : rx_data_reg_block
    if (!n_rst) begin
        real_rx_data = '0;
    end
    else begin
        real_rx_data = rx_data;
    end
end

// This it the port that connecting to address mapping comb
always_ff @( posedge clk, negedge n_rst ) begin : data_read_reg_block
    if (!n_rst) begin
        data_read = '0;
    end
    else begin
        data_read = next_data_read;
    end
end

// corresponds to the bottom 3 regs, this is bitperiod
always_ff @( posedge clk, negedge n_rst ) begin : bit_period_7_0_block
    if (!n_rst) begin
        bit_period_7_0 = '0;
    end
    else begin
        bit_period_7_0 = next_bit_period_7_0;
    end
end

// this is bitperiod2
always_ff @( posedge clk, negedge n_rst ) begin : bit_period_13_8_block
    if (!n_rst) begin
        bit_period_13_8 = '0;
    end
    else begin
        bit_period_13_8 = next_bit_period_13_8;
    end
end

// this is datasize
always_ff @( posedge clk, negedge n_rst ) begin : data_size_reg_block
    if (!n_rst) begin
        temp_data_size = '0;
    end
    else begin
        temp_data_size = next_temp_data_size;
    end
end

// error part should be always comb, not framing error | overrun error
always_comb begin : error
    if (overrun_error) begin
        input_error = 8'd2;
    end
    else if (framing_error) begin
        input_error = 8'd1;
    end
    else begin
        input_error = 8'd0;
    end
end

// this is the top mid mux for inputs
always_comb begin: prdata_mux
    next_data_read = 0;
    next_prdata = prdata;

    case(read_select)
        3'h0: next_prdata = {7'h0, data_ready};
        3'h1: next_prdata = input_error;
        3'h2: next_prdata = bit_period_7_0;
        3'h3: next_prdata = bit_period_13_8;
        3'h4: next_prdata = temp_data_size;
        3'h5: next_prdata = prdata;
        3'h6: begin 
            next_data_read = 1;
            next_prdata = real_rx_data;
        end
        default: next_prdata = 8'h0;
    endcase
end

//
always_comb begin : controlblock
    write_select = 3'd0; // default
    pslverr = '0;
    read_select = 3'd5;
    //
    if(pwrite) begin
        if (paddr != 3'd2 && paddr != 3'd3 && paddr != 3'd4) begin
            pslverr = '1;
        end
    end
    else begin
        if (paddr != 3'd0 && paddr != 3'd1 && paddr != 3'd2 && paddr != 3'd3 && paddr != 3'd4 && paddr != 3'd6) begin
            pslverr = '1;
        end
    end
    //
    if (psel) begin
        if (penable & pwrite) begin// time to write 
            case(paddr)
                3'd2: write_select = 3'd1;
                3'd3: write_select = 3'd2;
                3'd4: write_select = 3'b100; // this is a MUX, writing like I wrote in rtl will be a decoder
            endcase
        end
        else if (!pwrite) begin
            read_select = paddr;
        end
    end
end
//{2'b0, next_bit_period_13_8}
always_comb begin : writeblock
    next_bit_period_7_0 = bit_period_7_0;
    next_bit_period_13_8 = bit_period_13_8;
    next_temp_data_size = temp_data_size;

    case(write_select) 
        3'd1: next_bit_period_7_0 = pwdata;
        3'd2: next_bit_period_13_8 = pwdata;
        3'b100: next_temp_data_size = {4'b0, pwdata[3:0]};
    endcase
end

assign data_size = temp_data_size[3:0];
assign bit_period = {bit_period_13_8[5:0], bit_period_7_0[7:0]};

endmodule