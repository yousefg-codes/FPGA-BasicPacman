onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top_level_tb/dut/CLOCK_50
add wave -noupdate /top_level_tb/dut/reset
add wave -noupdate -radix unsigned /top_level_tb/dut/x
add wave -noupdate -radix unsigned /top_level_tb/dut/y
add wave -noupdate -radix unsigned /top_level_tb/dut/r
add wave -noupdate -radix unsigned /top_level_tb/dut/g
add wave -noupdate -radix unsigned /top_level_tb/dut/b
add wave -noupdate /top_level_tb/dut/rect_is_in
add wave -noupdate /top_level_tb/dut/curr_obj_type
add wave -noupdate /top_level_tb/dut/map_rom
add wave -noupdate /top_level_tb/dut/v1/CLOCK_25
add wave -noupdate /top_level_tb/dut/v1/x
add wave -noupdate /top_level_tb/dut/v1/y
add wave -noupdate /top_level_tb/dut/v1/read_enable
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
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
WaveRestoreZoom {0 ps} {1 ns}
