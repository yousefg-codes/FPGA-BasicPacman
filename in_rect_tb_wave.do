onerror {resume}
quietly virtual function -install /in_rect_tb -env /in_rect_tb { &{/in_rect_tb/bounds[37], /in_rect_tb/bounds[36], /in_rect_tb/bounds[35], /in_rect_tb/bounds[34], /in_rect_tb/bounds[33], /in_rect_tb/bounds[32], /in_rect_tb/bounds[31], /in_rect_tb/bounds[30], /in_rect_tb/bounds[29], /in_rect_tb/bounds[28], /in_rect_tb/bounds[27], /in_rect_tb/bounds[26], /in_rect_tb/bounds[25], /in_rect_tb/bounds[24], /in_rect_tb/bounds[23], /in_rect_tb/bounds[22], /in_rect_tb/bounds[21], /in_rect_tb/bounds[20], /in_rect_tb/bounds[19] }} x0
quietly virtual function -install /in_rect_tb -env /in_rect_tb { &{/in_rect_tb/bounds[37], /in_rect_tb/bounds[36], /in_rect_tb/bounds[35], /in_rect_tb/bounds[34], /in_rect_tb/bounds[33], /in_rect_tb/bounds[32], /in_rect_tb/bounds[31], /in_rect_tb/bounds[30], /in_rect_tb/bounds[29], /in_rect_tb/bounds[28] }} x0001
quietly virtual function -install /in_rect_tb -env /in_rect_tb { &{/in_rect_tb/bounds[27], /in_rect_tb/bounds[26], /in_rect_tb/bounds[25], /in_rect_tb/bounds[24], /in_rect_tb/bounds[23], /in_rect_tb/bounds[22], /in_rect_tb/bounds[21], /in_rect_tb/bounds[20], /in_rect_tb/bounds[19] }} y0
quietly WaveActivateNextPane {} 0
add wave -noupdate /in_rect_tb/clk
add wave -noupdate /in_rect_tb/is_in
add wave -noupdate /in_rect_tb/curr_point
add wave -noupdate -radix unsigned /in_rect_tb/x0001
add wave -noupdate -radix unsigned /in_rect_tb/y0
add wave -noupdate /in_rect_tb/bounds
add wave -noupdate /in_rect_tb/i
add wave -noupdate -radix unsigned /in_rect_tb/dut/curr_x
add wave -noupdate -radix unsigned /in_rect_tb/dut/curr_y
add wave -noupdate -radix unsigned /in_rect_tb/dut/x0
add wave -noupdate -radix unsigned /in_rect_tb/dut/y0
add wave -noupdate -radix unsigned /in_rect_tb/dut/x1
add wave -noupdate -radix unsigned /in_rect_tb/dut/y1
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
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
