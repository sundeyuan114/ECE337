
`timescale 1ns / 10ps

module tb_ahb_lite_fir_filter();

// Timing related constants
localparam CLK_PERIOD = 10;
localparam BUS_DELAY  = 800ps; // Based on FF propagation delay

// Sizing related constants
localparam DATA_WIDTH      = 2;
localparam ADDR_WIDTH      = 4;
localparam DATA_WIDTH_BITS = DATA_WIDTH * 8;
localparam DATA_MAX_BIT    = DATA_WIDTH_BITS - 1;
localparam ADDR_MAX_BIT    = ADDR_WIDTH - 1;

// Define our address mapping scheme via constants
localparam ADDR_STATUS      = 4'd0;
localparam ADDR_STATUS_BUSY = 4'd0;
localparam ADDR_STATUS_ERR  = 4'd1;
localparam ADDR_RESULT      = 4'd2;
localparam ADDR_SAMPLE      = 4'd4;
localparam ADDR_COEF_F0  = 4'd6;  // F0
localparam ADDR_COEF_F1 = 4'h8;
localparam ADDR_COEF_F2 = 4'ha;
localparam ADDR_COEF_F3 = 4'hc;
localparam ADDR_COEF_SET    = 4'd14; // Coeff Set Confirmation

// Define our custom test vector type
typedef struct
{
  reg [16:0] coeffs[3:0];
  reg [16:0] samples[3:0];
  reg [16:0] results[3:0];
  reg errors[3:0];
} testVector;

// AHB-Lite-Slave reset value constants
// Student TODO: Update these based on the reset values for your config registers
localparam RESET_COEFF  = '0;
localparam RESET_SAMPLE = '0;

localparam READ = 1'b0;
localparam WRITE = 1'b1;
localparam NOERR = 1'b0;
localparam ERR = 1'b1;
localparam SIZE_0 = 1'b0;
localparam SIZE_1 = 1'b1;

// Test coefficient constants
localparam COEFF1 		= 16'h8000; // 1.0
localparam COEFF_5 		= 16'h4000; // 0.5
localparam COEFF_25 	= 16'h2000; // 0.25
localparam COEFF_125 	= 16'h1000; // 0.125
localparam COEFF0  		= 16'h0000; // 0.0


testVector tb_test_vectors[];

//*****************************************************************************
// Declare TB Signals (Bus Model Controls)
//*****************************************************************************
// Testing setup signals
logic                      tb_enqueue_transaction;
logic                      tb_transaction_write;
logic                      tb_transaction_fake;
logic [ADDR_MAX_BIT:0]     tb_transaction_addr;
logic [DATA_MAX_BIT:0]     tb_transaction_data;
logic                      tb_transaction_error;
logic [2:0]                tb_transaction_size;
// Testing control signal(s)
logic    tb_enable_transactions;
integer  tb_current_transaction_num;
logic    tb_current_transaction_error;
logic    tb_model_reset;
string   tb_test_case;
integer  tb_test_case_num;
logic [DATA_MAX_BIT:0] tb_test_data;
string                 tb_check_tag;
logic                  tb_mismatch;
logic                  tb_check;

//*****************************************************************************
// General System signals
//*****************************************************************************
logic tb_clk;
logic tb_n_rst;

//*****************************************************************************
// AHB-Lite-Slave side signals
//*****************************************************************************
logic                  tb_hsel;
logic [1:0]            tb_htrans;
logic [ADDR_MAX_BIT:0] tb_haddr;
logic [2:0]            tb_hsize;
logic                  tb_hwrite;
logic [DATA_MAX_BIT:0] tb_hwdata;
logic [DATA_MAX_BIT:0] tb_hrdata;
logic                  tb_hresp;

//*****************************************************************************
// FIR Filter-side Signals
//*****************************************************************************
// From FIR Filter or Coefficient Loader (TB)
logic [DATA_MAX_BIT:0]  tb_fir_out;
logic                   tb_modwait;
logic                   tb_err;
logic [1:0]             tb_coeff_num;
logic                   tb_coeff_clr;
// To FIR Filter or Coefficient Loader (From DUT)
logic                   tb_data_ready;
logic [DATA_MAX_BIT:0]  tb_sample_data;
logic                   tb_new_coeff_set;
logic [DATA_MAX_BIT:0]  tb_fir_coefficient;

// Expected value check signals
logic                   tb_expected_data_ready;
logic [DATA_MAX_BIT:0]  tb_expected_sample;
logic                   tb_expected_new_coeff_set;
logic [DATA_MAX_BIT:0]  tb_expected_coeff;


//*****************************************************************************
// Clock Generation Block
//*****************************************************************************
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

// hrdata read module. 
////logic [15:0] read_reg, next_read_reg; 
//logic mdwait, next_mdwait;
//always_ff @ (posedge tb_clk, negedge tb_n_rst) begin
  //if(~tb_n_rst) read_reg <= '0;
  //else read_reg <= next_read_reg;
//end
//assign next_read_reg = tb_hrdata;

//*****************************************************************************
// Bus Model Instance
//*****************************************************************************
ahb_lite_bus BFM (.clk(tb_clk),
                  // Testing setup signals
                  .enqueue_transaction(tb_enqueue_transaction),
                  .transaction_write(tb_transaction_write),
                  .transaction_fake(tb_transaction_fake),
                  .transaction_addr(tb_transaction_addr),
                  .transaction_data(tb_transaction_data),
                  .transaction_error(tb_transaction_error),
                  .transaction_size(tb_transaction_size),
                  // Testing controls
                  .model_reset(tb_model_reset),
                  .enable_transactions(tb_enable_transactions),
                  .current_transaction_num(tb_current_transaction_num),
                  .current_transaction_error(tb_current_transaction_error),
                  // AHB-Lite-Slave Side
                  .hsel(tb_hsel),
                  .htrans(tb_htrans),
                  .haddr(tb_haddr),
                  .hsize(tb_hsize),
                  .hwrite(tb_hwrite),
                  .hwdata(tb_hwdata),
                  .hrdata(tb_hrdata),
                  .hresp(tb_hresp));


//*****************************************************************************
// DUT Instance
//*****************************************************************************
ahb_lite_fir_filter DUT (
  .clk(tb_clk), 
  .n_rst(tb_n_rst),
  .hsel(tb_hsel),
  .htrans(tb_htrans),
  .haddr(tb_haddr),
  .hsize(tb_hsize[0]),
  .hwrite(tb_hwrite),
  .hwdata(tb_hwdata),
  .hrdata(tb_hrdata),
  .hresp(tb_hresp)
);

//*****************************************************************************
// DUT Related TB Tasks
//*****************************************************************************
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

task configure;
  input [16:0] coeff [3:0];
begin
  enqueue_transaction(1'b1, WRITE, ADDR_COEF_F0, coeff[0], NOERR, SIZE_1);
  enqueue_transaction(1'b1, WRITE, ADDR_COEF_F1, coeff[1], NOERR, SIZE_1);
  enqueue_transaction(1'b1, WRITE, ADDR_COEF_F2, coeff[2], NOERR, SIZE_1);
  enqueue_transaction(1'b1, WRITE, ADDR_COEF_F3, coeff[3], NOERR, SIZE_1);
  enqueue_transaction(1'b1, WRITE, ADDR_COEF_SET, 16'h0001, NOERR, SIZE_1);
  execute_transactions(5);

end
endtask

task test_stream;
  input testVector tv;
  integer s;
begin
  configure(tv.coeffs);
  #(20 * CLK_PERIOD);
  for(s = 0; s < 4; s++) begin
    test_sample(tv.samples[s], tv.results[s], tv.errors[s]);
  end
end
endtask


task test_sample;
  input [15:0] sample_value;
		
  // Expected outputs
  input [15:0] expected_fir_out;
  input expected_err;

begin
  enqueue_transaction(1'b1, WRITE, ADDR_SAMPLE, sample_value, NOERR, SIZE_1);
  execute_transactions(1);
  //enqueue_transaction(1'b1, READ, ADDR_STATUS, 16'b1, NOERR, SIZE_1);
  //execute_transactions(1);
  //while (read_reg[0]) begin
    //enqueue_transaction(1'b1, READ, ADDR_STATUS, 16'b1, NOERR, SIZE_1);
  //end
  #(20 * CLK_PERIOD);
  enqueue_transaction(1'b1, READ, ADDR_RESULT, expected_fir_out, NOERR, SIZE_1);
  execute_transactions(1);

  #(CLK_PERIOD);

end
endtask


//*****************************************************************************
// Bus Model Usage Related TB Tasks
//*****************************************************************************
// Task to pulse the reset for the bus model
task reset_model;
begin
  tb_model_reset = 1'b1;
  #(0.1);
  tb_model_reset = 1'b0;
end
endtask

// Task to enqueue a new transaction
task enqueue_transaction;
  input logic for_dut;
  input logic write_mode;
  input logic [ADDR_MAX_BIT:0] address;
  input logic [DATA_MAX_BIT:0] data;
  input logic expected_error;
  input logic size;
begin
  // Make sure enqueue flag is low (will need a 0->1 pulse later)
  tb_enqueue_transaction = 1'b0;
  #0.1ns;

  // Setup info about transaction
  tb_transaction_fake  = ~for_dut;
  tb_transaction_write = write_mode;
  tb_transaction_addr  = address;
  tb_transaction_data  = data;
  tb_transaction_error = expected_error;
  tb_transaction_size  = {2'b00,size};

  // Pulse the enqueue flag
  tb_enqueue_transaction = 1'b1;
  #0.1ns;
  tb_enqueue_transaction = 1'b0;
end
endtask

// Task to wait for multiple transactions to happen
task execute_transactions;
  input integer num_transactions;
  integer wait_var;
begin
  // Activate the bus model
  tb_enable_transactions = 1'b1;
  @(posedge tb_clk);

  // Process the transactions (all but last one overlap 1 out of 2 cycles
  for(wait_var = 0; wait_var < num_transactions; wait_var++) begin
    @(posedge tb_clk);
  end

  // Run out the last one (currently in data phase)
  @(posedge tb_clk);

  // Turn off the bus model
  @(negedge tb_clk);
  tb_enable_transactions = 1'b0;
end
endtask

// Task to clear/initialize all FIR-side inputs
task init_fir_side;
begin
  tb_fir_out   = '0;
  tb_modwait   = 1'b0;
  tb_err       = 1'b0;
  tb_coeff_num = 2'd0;
  tb_coeff_clr = 0;
end
endtask

// Task to clear/initialize all FIR-side inputs
task init_expected_outs;
begin
  tb_expected_data_ready    = 1'b0;
  tb_expected_sample        = RESET_SAMPLE;
  tb_expected_new_coeff_set = 1'b0;
  tb_expected_coeff         = RESET_COEFF;
end
endtask

initial
begin // TODO: Add more standard test cases here
  // Populate the test vector array to use
  tb_test_vectors = new[2];
  // Test case 0
  tb_test_vectors[0].coeffs	= {COEFF_5, COEFF1, COEFF1, COEFF_5};
  tb_test_vectors[0].samples	= {16'd100, 16'd100, 16'd100, 16'd100};
  tb_test_vectors[0].results	= {16'd0, 16'd50, 16'd50 ,16'd50};
	tb_test_vectors[0].errors		= {1'b0, 1'b0, 1'b0, 1'b0};
  // Test case 1
  tb_test_vectors[1].coeffs		= tb_test_vectors[0].coeffs;
  tb_test_vectors[1].samples	= {16'd1000, 16'd1000, 16'd100, 16'd100};
  tb_test_vectors[1].results	= {16'd450, 16'd500, 16'd50 ,16'd50};
  tb_test_vectors[1].errors		= {1'b0, 1'b0, 1'b0, 1'b0};
end

//*****************************************************************************
//*****************************************************************************
// Main TB Process
//*****************************************************************************
//*****************************************************************************
initial begin
  // Initialize Test Case Navigation Signals
  tb_test_case       = "Initilization";
  tb_test_case_num   = -1;
  tb_test_data       = '0;
  tb_check_tag       = "N/A";
  tb_check           = 1'b0;
  tb_mismatch        = 1'b0;
  // Initialize all of the directly controled DUT inputs
  tb_n_rst          = 1'b1;
  init_fir_side();
  // Initialize all of the bus model control inputs
  tb_model_reset          = 1'b0;
  tb_enable_transactions  = 1'b0;
  tb_enqueue_transaction  = 1'b0;
  tb_transaction_write    = 1'b0;
  tb_transaction_fake     = 1'b0;
  tb_transaction_addr     = '0;
  tb_transaction_data     = '0;
  tb_transaction_error    = 1'b0;
  tb_transaction_size     = 3'd0;

  // Wait some time before starting first test case
  #(0.1);

  // Clear the bus model
  reset_model();

  //*****************************************************************************
  // Power-on-Reset Test Case 0
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "Power-on-Reset";
  tb_test_case_num = tb_test_case_num + 1;
  
  // Setup FIR Filter provided signals with 'active' values for reset check
  tb_fir_out   = '1;
  tb_modwait   = 1'b1;
  tb_err       = 1'b1;
  tb_coeff_num = 2'd1;

  // Reset the DUT
  reset_dut();

  enqueue_transaction(1'b1, READ, ADDR_COEF_F0, 16'b0, NOERR, SIZE_1);
  enqueue_transaction(1'b1, READ, ADDR_COEF_F1, 16'b0, NOERR, SIZE_1);
  enqueue_transaction(1'b1, READ, ADDR_COEF_F2, 16'b0, NOERR, SIZE_1);
  enqueue_transaction(1'b1, READ, ADDR_COEF_F3, 16'b0, NOERR, SIZE_1);
  enqueue_transaction(1'b1, READ, ADDR_RESULT, 16'b0, NOERR, SIZE_1);
  enqueue_transaction(1'b1, READ, ADDR_STATUS, 16'b0, NOERR, SIZE_1);
  enqueue_transaction(1'b1, READ, ADDR_SAMPLE, 16'b0, NOERR, SIZE_1);
  enqueue_transaction(1'b1, READ, ADDR_COEF_SET, 16'b0, NOERR, SIZE_1);
  execute_transactions(8);


// task enqueue_transaction;
//   input logic for_dut;
//   input logic write_mode;
//   input logic [ADDR_MAX_BIT:0] address;
//   input logic [DATA_MAX_BIT:0] data;
//   input logic expected_error;
//   input logic size;
// begin
  // Give some visual spacing between check and next test case start
  #(CLK_PERIOD * 3);

  //*****************************************************************************
  // Test Case 1: sample value
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "Send Sample";
  tb_test_case_num = tb_test_case_num + 1;
  init_fir_side();
  init_expected_outs();

  
  // Reset the DUT to isolate from prior test case
  reset_dut();

  tb_test_data = 16'd1000; 
  enqueue_transaction(1'b1, WRITE, ADDR_SAMPLE, tb_test_data, NOERR, SIZE_1);
  execute_transactions(1);
  enqueue_transaction(1'b1, READ, ADDR_SAMPLE, tb_test_data, NOERR, SIZE_1);
  execute_transactions(1);

  #(CLK_PERIOD * 3);
  $info("test case %d, %s finished", tb_test_case_num, tb_test_case);

  //*****************************************************************************
  // Test Case 2: Coefficient Value
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = " Coeff ";
  tb_test_case_num = tb_test_case_num + 1;
  init_fir_side();
  init_expected_outs();

  reset_dut();

  configure(tb_test_vectors[0].coeffs);
  enqueue_transaction(1'b1, READ, ADDR_COEF_F0, tb_test_vectors[0].coeffs[0], NOERR, SIZE_1);
  enqueue_transaction(1'b1, READ, ADDR_COEF_F1, tb_test_vectors[0].coeffs[1], NOERR, SIZE_1);
  enqueue_transaction(1'b1, READ, ADDR_COEF_F2, tb_test_vectors[0].coeffs[2], NOERR, SIZE_1);
  enqueue_transaction(1'b1, READ, ADDR_COEF_F3, tb_test_vectors[0].coeffs[3], NOERR, SIZE_1);
  execute_transactions(4);

  $info("test case %d, %s finished", tb_test_case_num, tb_test_case);

  // Give some visual spacing between check and next test case start
  #(CLK_PERIOD * 5);
  

  //*****************************************************************************
  // Test Case 3: vector 
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "vector";
  tb_test_case_num = tb_test_case_num + 1;
  reset_dut();
  test_stream(tb_test_vectors[0]);
  reset_dut();
  test_stream(tb_test_vectors[1]);

  $info("test case %d, %s finished", tb_test_case_num, tb_test_case);

 //*****************************************************************************
  // Test Case 4: send sample test
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "send sample";
  tb_test_case_num = tb_test_case_num + 1;
  init_fir_side();
  init_expected_outs();

  reset_dut();
  tb_test_data = tb_test_vectors[0].samples[1];
  enqueue_transaction(1'b1, WRITE, ADDR_SAMPLE, tb_test_data, NOERR, SIZE_1);
  enqueue_transaction(1'b1, READ, ADDR_SAMPLE, tb_test_data, NOERR, SIZE_1);
  execute_transactions(2);

  $info("test case %d, %s finished", tb_test_case_num, tb_test_case);

  //*****************************************************************************
  // Test Case 5: err test
  //*****************************************************************************
  tb_test_case     = "err test";
  tb_test_case_num = tb_test_case_num + 1;
  init_fir_side();
  init_expected_outs();

  reset_dut();
  enqueue_transaction(1'b1, WRITE, ADDR_RESULT, 16'h0100, ERR, SIZE_1);
  enqueue_transaction(1'b1, WRITE, ADDR_STATUS, 16'h0100, ERR, SIZE_1);
  enqueue_transaction(1'b1, WRITE, 4'hf, 16'h2, ERR, SIZE_0);
  execute_transactions(3);

  $info("test case %d, %s finished", tb_test_case_num, tb_test_case);


  //*****************************************************************************
  // Test Case 6: 
  //*****************************************************************************
//   tb_test_case     = "vector test";
//   tb_test_case_num = tb_test_case_num + 1;
//   // Reset the DUT to isolate from prior test case
//   reset_dut();

//   enqueue_transaction(1'b1, WRITE, ADDR_COEF_SET, 1'b1, NOERR, SIZE_1);
//   //

//   //f0 f1 f2 f3
//   enqueue_transaction(1'b1, WRITE, ADDR_COEF_F0, COEFF1, NOERR, SIZE_1);
//   enqueue_transaction(1'b1, WRITE, ADDR_COEF_F1, COEFF1, NOERR, SIZE_1);
//   enqueue_transaction(1'b1, WRITE, ADDR_COEF_F2, COEFF1, NOERR, SIZE_1);
//   enqueue_transaction(1'b1, WRITE, ADDR_COEF_F3, COEFF1, NOERR, SIZE_1);

  

end

endmodule