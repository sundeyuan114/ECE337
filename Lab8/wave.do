onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_apb_uart_rx/tb_enqueue_transaction
add wave -noupdate /tb_apb_uart_rx/tb_transaction_write
add wave -noupdate /tb_apb_uart_rx/tb_transaction_fake
add wave -noupdate /tb_apb_uart_rx/tb_transaction_addr
add wave -noupdate /tb_apb_uart_rx/tb_transaction_data
add wave -noupdate /tb_apb_uart_rx/tb_transaction_error
add wave -noupdate /tb_apb_uart_rx/tb_enable_transactions
add wave -noupdate /tb_apb_uart_rx/tb_current_transaction_num
add wave -noupdate /tb_apb_uart_rx/tb_model_reset
add wave -noupdate /tb_apb_uart_rx/tb_test_case_num
add wave -noupdate /tb_apb_uart_rx/tb_test_data
add wave -noupdate /tb_apb_uart_rx/tb_test_bit_period
add wave -noupdate /tb_apb_uart_rx/tb_mismatch
add wave -noupdate /tb_apb_uart_rx/tb_check
add wave -noupdate /tb_apb_uart_rx/tb_clk
add wave -noupdate /tb_apb_uart_rx/tb_n_rst
add wave -noupdate /tb_apb_uart_rx/tb_psel
add wave -noupdate /tb_apb_uart_rx/tb_paddr
add wave -noupdate /tb_apb_uart_rx/tb_penable
add wave -noupdate /tb_apb_uart_rx/tb_pwrite
add wave -noupdate /tb_apb_uart_rx/tb_pwdata
add wave -noupdate /tb_apb_uart_rx/tb_prdata
add wave -noupdate /tb_apb_uart_rx/tb_pslverr
add wave -noupdate /tb_apb_uart_rx/tb_data_size
add wave -noupdate /tb_apb_uart_rx/tb_expected_data_read
add wave -noupdate /tb_apb_uart_rx/tb_expected_data_size
add wave -noupdate /tb_apb_uart_rx/tb_expected_bit_period
add wave -noupdate /tb_apb_uart_rx/tb_serial_in
add wave -noupdate /tb_apb_uart_rx/bit_stream
add wave -noupdate /tb_apb_uart_rx/DUT/apb_slave1/prdata
add wave -noupdate /tb_apb_uart_rx/DUT/apb_slave1/next_prdata
add wave -noupdate /tb_apb_uart_rx/DUT/apb_slave1/read_select
add wave -noupdate /tb_apb_uart_rx/DUT/apb_slave1/pwdata
add wave -noupdate /tb_apb_uart_rx/DUT/apb_slave1/paddr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {185000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {2100 ns}
