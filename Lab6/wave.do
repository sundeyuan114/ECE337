onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_rcv_block/tb_clk
add wave -noupdate /tb_rcv_block/tb_n_rst
add wave -noupdate /tb_rcv_block/tb_serial_in
add wave -noupdate /tb_rcv_block/tb_data_read
add wave -noupdate /tb_rcv_block/tb_rx_data
add wave -noupdate /tb_rcv_block/tb_data_ready
add wave -noupdate /tb_rcv_block/tb_overrun_error
add wave -noupdate /tb_rcv_block/tb_framing_error
add wave -noupdate /tb_rcv_block/tb_test_num
add wave -noupdate /tb_rcv_block/tb_test_case
add wave -noupdate /tb_rcv_block/tb_test_data
add wave -noupdate /tb_rcv_block/tb_test_stop_bit
add wave -noupdate /tb_rcv_block/tb_test_bit_period
add wave -noupdate /tb_rcv_block/tb_test_data_read
add wave -noupdate /tb_rcv_block/tb_expected_rx_data
add wave -noupdate /tb_rcv_block/tb_expected_framing_error
add wave -noupdate /tb_rcv_block/tb_expected_data_ready
add wave -noupdate /tb_rcv_block/tb_expected_overrun
add wave -noupdate /tb_rcv_block/DUT/timer1/enable_timer
add wave -noupdate /tb_rcv_block/DUT/timer1/shift_strobe
add wave -noupdate /tb_rcv_block/DUT/timer1/packet_done
add wave -noupdate /tb_rcv_block/DUT/timer1/shift_enable
add wave -noupdate /tb_rcv_block/DUT/rcu1/new_packet_detected
add wave -noupdate /tb_rcv_block/DUT/rcu1/packet_done
add wave -noupdate /tb_rcv_block/DUT/rcu1/framing_error
add wave -noupdate /tb_rcv_block/DUT/rcu1/sbc_clear
add wave -noupdate /tb_rcv_block/DUT/rcu1/sbc_enable
add wave -noupdate /tb_rcv_block/DUT/rcu1/load_buffer
add wave -noupdate /tb_rcv_block/DUT/rcu1/enable_timer
add wave -noupdate /tb_rcv_block/DUT/rcu1/next_state
add wave -noupdate /tb_rcv_block/DUT/rcu1/state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {320081 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 209
configure wave -valuecolwidth 216
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
WaveRestoreZoom {302154 ps} {339306 ps}
