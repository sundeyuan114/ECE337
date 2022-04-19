onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_ahb_lite_fir_filter/DUT/clk
add wave -noupdate /tb_ahb_lite_fir_filter/DUT/n_rst
add wave -noupdate /tb_ahb_lite_fir_filter/DUT/hsel
add wave -noupdate /tb_ahb_lite_fir_filter/DUT/haddr
add wave -noupdate /tb_ahb_lite_fir_filter/DUT/hsize
add wave -noupdate /tb_ahb_lite_fir_filter/DUT/htrans
add wave -noupdate /tb_ahb_lite_fir_filter/DUT/hwrite
add wave -noupdate /tb_ahb_lite_fir_filter/DUT/hwdata
add wave -noupdate /tb_ahb_lite_fir_filter/DUT/hrdata
add wave -noupdate /tb_ahb_lite_fir_filter/DUT/hresp
add wave -noupdate /tb_ahb_lite_fir_filter/DUT/sample_data
add wave -noupdate /tb_ahb_lite_fir_filter/DUT/fir_coefficient
add wave -noupdate /tb_ahb_lite_fir_filter/DUT/fir_out
add wave -noupdate /tb_ahb_lite_fir_filter/DUT/coefficient_num
add wave -noupdate /tb_ahb_lite_fir_filter/DUT/err
add wave -noupdate /tb_ahb_lite_fir_filter/DUT/data_ready
add wave -noupdate /tb_ahb_lite_fir_filter/DUT/modwait
add wave -noupdate /tb_ahb_lite_fir_filter/DUT/new_coefficient_set
add wave -noupdate /tb_ahb_lite_fir_filter/DUT/coef_clear
add wave -noupdate /tb_ahb_lite_fir_filter/DUT/load_coef
add wave -noupdate /tb_ahb_lite_fir_filter/tb_test_case_num
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1 ns}
