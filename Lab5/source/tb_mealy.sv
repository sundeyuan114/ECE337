// $Id: $
// File name:   tb_pts_sr_4_msb.sv
// Created:     9/14/2018
// Author:      Tim Pritchett
// Lab Section: 9999
// Version:     1.0  Initial Design Entry
// Description: Test bench for the default settings versions of Flex PTS SR

`timescale 1ns / 10ps

module tb_mealy();
  // Define parameters
  // Common parameters
  localparam CLK_PERIOD        = 2.5;
  localparam PROPAGATION_DELAY = 0.8; // Allow for 800 ps for FF propagation delay

  localparam  INACTIVE_VALUE     = 1'b1;
  localparam  SR_SIZE_BITS       = 4;
  localparam  SR_MAX_BIT         = SR_SIZE_BITS - 1;
  localparam  RESET_OUTPUT_VALUE = 1'b1;

  // Declare Test Case Signals
  integer tb_test_num;
  string  tb_test_case;
  string  tb_stream_check_tag;
  integer tb_bit_num;
  integer tb_curr_bit_index;
  logic   tb_mismatch;
  logic   tb_check;

  // Declare the Test Bench Signals for Expected Results
  logic                tb_expected_ouput;
  logic  tb_test_data [];

  // Declare DUT Connection Signals
  logic                tb_clk;
  logic                tb_n_rst;
  logic                tb_i;
  logic                tb_o;
  
  // Task for standard DUT reset procedure
  task reset_dut;
  begin
    // Activate the reset
    tb_n_rst = 1'b0;

    // Maintain the reset for more than one cycle
    @(posedge tb_clk);
    @(posedge tb_clk);

    // Wait until safely away from rising edge of the clock before releasing
    @(negedge tb_clk);
    tb_n_rst = 1'b1;

    // Leave out of reset for a couple cycles before allowing other stimulus
    // Wait for negative clock edges, 
    // since inputs to DUT should normally be applied away from rising clock edges
    @(negedge tb_clk);
    @(negedge tb_clk);
  end
  endtask

  // Task to cleanly and consistently check DUT output values
  task check_output;
    input string check_tag;
  begin
    tb_mismatch = 1'b0;
    tb_check    = 1'b1;
    if(tb_expected_ouput == tb_o) begin // Check passed
      $info("Correct serial output %s during %s test case", check_tag, tb_test_case);
    end
    else begin // Check failed
      tb_mismatch = 1'b1;
      $error("Incorrect serial output %s during %s test case", check_tag, tb_test_case);
    end

    // Wait some small amount of time so check pulse timing is visible on waves
    #(0.1);
    tb_check =1'b0;
  end
  endtask

  // Task to manage the timing of sending one bit out of the shift register
  task send_bit;
    input logic bit2send;
  begin
    // Synchronize to the negative edge of clock to prevent timing errors
    @(negedge tb_clk);
    
    // Activate the shift enable
    tb_i = bit2send;

    // Wait for the value to have been shifted in on the rising clock edge
    @(posedge tb_clk);
    #(PROPAGATION_DELAY);
  end
  endtask

  // Task to manage the timing of loading a new bit vector into the shift register

  // Task to contiguosly send a stream of bits through the shift register
  task send_stream;
    input logic stream2send [];
  begin

    for(tb_bit_num = 0; tb_bit_num < stream2send.size(); tb_bit_num++) begin
      send_bit(stream2send[tb_bit_num]);
    end
  end
  endtask

  // Clock generation block
  always begin
    // Start with clock low to avoid false rising edge events at t=0
    tb_clk = 1'b0;
    // Wait half of the clock period before toggling clock value (maintain 50% duty cycle)
    #(CLK_PERIOD/2.0);
    tb_clk = 1'b1;
    // Wait half of the clock period before toggling clock value via rerunning the block (maintain 50% duty cycle)
    #(CLK_PERIOD/2.0);
  end

  // DUT Portmap
//   moore DUT (.clk(tb_clk), .n_rst(tb_n_rst),
//                     .parallel_in(tb_parallel_in),
//                     .shift_enable(tb_shift_enable),
//                     .load_enable(tb_load_enable),
//                     .serial_out(tb_serial_out));
  mealy DUT (.clk(tb_clk), .n_rst(tb_n_rst),
                    .i(tb_i),
                    .o(tb_o));
// module name (
//     input logic clk,
//     input logic n_rst,
//     input logic i,
//     output logic o
// );
  // Test bench main process
  initial begin
    // Initialize all of the test inputs
    tb_n_rst            = 1'b1; // Initialize to be inactive
    tb_test_num         = 0;    // Initialize test case counter
    tb_test_case        = "Test bench initializaton";
    tb_stream_check_tag = "N/A";
    tb_bit_num          = -1;   // Initialize to invalid number
    tb_curr_bit_index   = -1;   // Initialize to invalid number
    tb_mismatch         = 1'b0;
    tb_check            = 1'b0;
    // Wait some time before starting first test case
    #(0.1);

    // ************************************************************************
    // Test Case 1: Power-on Reset of the DUT
    // ************************************************************************
    tb_test_num  = tb_test_num + 1;
    tb_test_case = "Power on Reset";
    // Note: Do not use reset task during reset test case since we need to specifically check behavior during reset
    // Wait some time before applying test case stimulus
    #(0.1);
    // Apply test case initial stimulus (non-reset value parralel input)
    tb_n_rst       = 1'b0;

    // Wait for a bit before checking for correct functionality
    #(CLK_PERIOD * 0.5);

    // Check that internal state was correctly reset
    tb_expected_ouput = 1'b0;
    check_output("after reset applied");

    // Check that the reset value is maintained during a clock cycle
    #(CLK_PERIOD);
    check_output("after clock cycle while in reset");
    
    // Release the reset away from a clock edge
    @(negedge tb_clk);
    tb_n_rst  = 1'b1;   // Deactivate the chip reset
    // Check that internal state was correctly keep after reset release
    #(PROPAGATION_DELAY);
    check_output("after reset was released");

    // ************************************************************************
    // Test Case 2: basic 1101 check
    // ************************************************************************
    tb_test_num  = tb_test_num + 1;
    tb_test_case = "basic 1101 check";
    // Start out with inactive value and reset the DUT to isolate from prior tests
    tb_i = 1'b0;
    reset_dut();
    tb_expected_ouput = 1'b0;

    tb_test_data = {1,1,0,1};
    send_stream(tb_test_data);

    // Check that proper fill value was used during shifting
    @(negedge tb_clk);
    tb_expected_ouput = 1'b1;
    check_output("basic 1101 success");

    // ************************************************************************
    // Test Case 3: overlap case like 1101101
    // ************************************************************************
    tb_test_num  = tb_test_num + 1;
    tb_test_case = "overlap case like 1101101";
    // Start out with inactive value and reset the DUT to isolate from prior tests
    tb_i = 1'b0;
    reset_dut();
    tb_expected_ouput = 1'b0;

    tb_test_data = {1,1,0,1,1,0,1};
    send_stream(tb_test_data);

    @(negedge tb_clk);
    tb_expected_ouput = 1'b1;
    check_output("overlap 1101 success");
    // STUDENT TODO: Add more test cases here

  end
endmodule
