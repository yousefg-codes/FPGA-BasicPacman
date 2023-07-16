onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /pellet_tb/clk
add wave -noupdate /pellet_tb/reset
add wave -noupdate /pellet_tb/pacman_top_left
add wave -noupdate /pellet_tb/pacman_bottom_right
add wave -noupdate /pellet_tb/pellet_top_left
add wave -noupdate /pellet_tb/pellet_bottom_right
add wave -noupdate /pellet_tb/score
add wave -noupdate /pellet_tb/dut/eaten_x0
add wave -noupdate /pellet_tb/dut/eaten_x1
add wave -noupdate /pellet_tb/dut/eaten_y0
add wave -noupdate /pellet_tb/dut/eaten_y1
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {205 ps} 0}
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {1698 ps}
