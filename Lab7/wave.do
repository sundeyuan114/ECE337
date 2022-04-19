onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_fir_filter/tb_clk
add wave -noupdate /tb_fir_filter/tb_n_reset
add wave -noupdate /tb_fir_filter/tb_data_ready
add wave -noupdate /tb_fir_filter/tb_load_coeff
add wave -noupdate /tb_fir_filter/tb_sample
add wave -noupdate /tb_fir_filter/tb_coeff
add wave -noupdate /tb_fir_filter/tb_one_k_samples
add wave -noupdate /tb_fir_filter/tb_modwait
add wave -noupdate /tb_fir_filter/tb_err
add wave -noupdate /tb_fir_filter/tb_fir_out
add wave -noupdate /tb_fir_filter/tb_test_case_num
add wave -noupdate /tb_fir_filter/tb_test_sample_num
add wave -noupdate /tb_fir_filter/tb_std_test_case
add wave -noupdate /tb_fir_filter/tb_expected_fir_out
add wave -noupdate /tb_fir_filter/tb_expected_err
add wave -noupdate /tb_fir_filter/tb_expected_one_k_samples
add wave -noupdate /tb_fir_filter/DUT/controller1/state
add wave -noupdate /tb_fir_filter/DUT/controller1/op
add wave -noupdate /tb_fir_filter/DUT/controller1/dest
add wave -noupdate /tb_fir_filter/DUT/controller1/src1
add wave -noupdate /tb_fir_filter/DUT/controller1/src2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {1969882 ps} {2001586 ps}
