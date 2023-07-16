onerror {resume}
quietly virtual function -install /pacman_move_tb -env /pacman_move_tb { &{/pacman_move_tb/pacman_top_left[8], /pacman_move_tb/pacman_top_left[7], /pacman_move_tb/pacman_top_left[6], /pacman_move_tb/pacman_top_left[5], /pacman_move_tb/pacman_top_left[4], /pacman_move_tb/pacman_top_left[3], /pacman_move_tb/pacman_top_left[2], /pacman_move_tb/pacman_top_left[1], /pacman_move_tb/pacman_top_left[0] }} pacman_y0
quietly virtual function -install /pacman_move_tb -env /pacman_move_tb { &{/pacman_move_tb/pacman_top_left[18], /pacman_move_tb/pacman_top_left[17], /pacman_move_tb/pacman_top_left[16], /pacman_move_tb/pacman_top_left[15], /pacman_move_tb/pacman_top_left[14], /pacman_move_tb/pacman_top_left[13], /pacman_move_tb/pacman_top_left[12], /pacman_move_tb/pacman_top_left[11], /pacman_move_tb/pacman_top_left[10], /pacman_move_tb/pacman_top_left[9] }} pacman_x0
quietly virtual function -install /pacman_move_tb -env /pacman_move_tb { &{/pacman_move_tb/pacman_bottom_right[18], /pacman_move_tb/pacman_bottom_right[17], /pacman_move_tb/pacman_bottom_right[16], /pacman_move_tb/pacman_bottom_right[15], /pacman_move_tb/pacman_bottom_right[14], /pacman_move_tb/pacman_bottom_right[13], /pacman_move_tb/pacman_bottom_right[12], /pacman_move_tb/pacman_bottom_right[11], /pacman_move_tb/pacman_bottom_right[10], /pacman_move_tb/pacman_bottom_right[9] }} pacman_x1
quietly virtual function -install /pacman_move_tb -env /pacman_move_tb { &{/pacman_move_tb/pacman_bottom_right[8], /pacman_move_tb/pacman_bottom_right[7], /pacman_move_tb/pacman_bottom_right[6], /pacman_move_tb/pacman_bottom_right[5], /pacman_move_tb/pacman_bottom_right[4], /pacman_move_tb/pacman_bottom_right[3], /pacman_move_tb/pacman_bottom_right[2], /pacman_move_tb/pacman_bottom_right[1], /pacman_move_tb/pacman_bottom_right[0] }} pacman_y1
quietly WaveActivateNextPane {} 0
add wave -noupdate /pacman_move_tb/clk
add wave -noupdate /pacman_move_tb/reset
add wave -noupdate /pacman_move_tb/n8_left
add wave -noupdate /pacman_move_tb/n8_right
add wave -noupdate /pacman_move_tb/n8_up
add wave -noupdate /pacman_move_tb/n8_down
add wave -noupdate -radix unsigned /pacman_move_tb/pacman_y0
add wave -noupdate -radix unsigned /pacman_move_tb/pacman_x0
add wave -noupdate -radix unsigned /pacman_move_tb/pacman_x1
add wave -noupdate -radix unsigned /pacman_move_tb/pacman_y1
add wave -noupdate /pacman_move_tb/pacman_top_left
add wave -noupdate /pacman_move_tb/pacman_bottom_right
add wave -noupdate /pacman_move_tb/dut/i_done
add wave -noupdate -expand -group {Control Signals} /pacman_move_tb/dut/init_regs_and_move
add wave -noupdate -expand -group {Control Signals} /pacman_move_tb/dut/incr_i
add wave -noupdate -expand -group {Control Signals} /pacman_move_tb/dut/check_collisions
add wave -noupdate -expand -group {Control Signals} /pacman_move_tb/dut/viable_move
add wave -noupdate -expand -group {Map ROM} /pacman_move_tb/dut/rect_addr
add wave -noupdate -expand -group {Map ROM} /pacman_move_tb/dut/curr_rect
add wave -noupdate /pacman_move_tb/dut/pacman_dp/movement_sel
add wave -noupdate -group {Valid Moves} /pacman_move_tb/dut/pacman_dp/up_works
add wave -noupdate -group {Valid Moves} /pacman_move_tb/dut/pacman_dp/down_works
add wave -noupdate -group {Valid Moves} /pacman_move_tb/dut/pacman_dp/left_works
add wave -noupdate -group {Valid Moves} /pacman_move_tb/dut/pacman_dp/right_works
add wave -noupdate /pacman_move_tb/dut/pacman_ctrl/ps
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {204 ps} 0}
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
