onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group test_case_info /tb_adder_16bit/tb_test_case_num
add wave -noupdate -expand -group test_case_info -format Literal /tb_adder_16bit/tb_test_case_err
add wave -noupdate -divider {New Divider}
add wave -noupdate -expand -group expect -color Coral /tb_adder_16bit/tb_expected_outs
add wave -noupdate -expand -group expect -color Coral /tb_adder_16bit/tb_expected_sum
add wave -noupdate -expand -group expect -color Coral /tb_adder_16bit/tb_expected_overflow
add wave -noupdate -divider {New Divider}
add wave -noupdate -expand -group tb -color Red /tb_adder_16bit/tb_a
add wave -noupdate -expand -group tb -color Red /tb_adder_16bit/tb_b
add wave -noupdate -expand -group tb -color Red /tb_adder_16bit/tb_carry_in
add wave -noupdate -expand -group tb -color {Cornflower Blue} /tb_adder_16bit/tb_sum
add wave -noupdate -expand -group tb -color {Cornflower Blue} /tb_adder_16bit/tb_overflow
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {24661 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 254
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
WaveRestoreZoom {0 ps} {69520 ps}
