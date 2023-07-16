onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /ghost_algorithm_tb/clk
add wave -noupdate /ghost_algorithm_tb/reset
add wave -noupdate -radix unsigned /ghost_algorithm_tb/pacman_left_x
add wave -noupdate -radix unsigned /ghost_algorithm_tb/pacman_top_y
add wave -noupdate /ghost_algorithm_tb/ghost_top_left
add wave -noupdate /ghost_algorithm_tb/ghost_bottom_right
add wave -noupdate /ghost_algorithm_tb/kill_pac
add wave -noupdate -expand -group {Status Signals} /ghost_algorithm_tb/dut/i_done
add wave -noupdate -expand -group {Control Signals} /ghost_algorithm_tb/dut/calc_diff
add wave -noupdate -expand -group {Control Signals} /ghost_algorithm_tb/dut/init_regs
add wave -noupdate -expand -group {Control Signals} /ghost_algorithm_tb/dut/incr_i
add wave -noupdate -expand -group {Control Signals} /ghost_algorithm_tb/dut/check_collisions
add wave -noupdate -expand -group {Control Signals} /ghost_algorithm_tb/dut/viable_move
add wave -noupdate -group ROM /ghost_algorithm_tb/dut/rect_addr
add wave -noupdate -group ROM /ghost_algorithm_tb/dut/curr_rect
add wave -noupdate /ghost_algorithm_tb/dut/ghost_ctrl/ps
add wave -noupdate -expand -group {DP Internal} -radix decimal /ghost_algorithm_tb/dut/ghost_dp/dX
add wave -noupdate -expand -group {DP Internal} -radix decimal /ghost_algorithm_tb/dut/ghost_dp/dY
add wave -noupdate -expand -group {DP Internal} /ghost_algorithm_tb/dut/ghost_dp/is_x_obstructed
add wave -noupdate -expand -group {DP Internal} /ghost_algorithm_tb/dut/ghost_dp/is_y_obstructed
add wave -noupdate -expand -group {DP Internal} -expand -group {Rect Coords In} -radix unsigned /ghost_algorithm_tb/dut/ghost_dp/x0
add wave -noupdate -expand -group {DP Internal} -expand -group {Rect Coords In} -radix unsigned /ghost_algorithm_tb/dut/ghost_dp/y0
add wave -noupdate -expand -group {DP Internal} -expand -group {Rect Coords In} -radix unsigned /ghost_algorithm_tb/dut/ghost_dp/x1
add wave -noupdate -expand -group {DP Internal} -expand -group {Rect Coords In} -radix unsigned /ghost_algorithm_tb/dut/ghost_dp/y1
add wave -noupdate -expand -group {DP Internal} -expand -group {Ghost Coords Out} -radix unsigned /ghost_algorithm_tb/dut/ghost_dp/ghost_x0
add wave -noupdate -expand -group {DP Internal} -expand -group {Ghost Coords Out} -radix unsigned /ghost_algorithm_tb/dut/ghost_dp/ghost_y0
add wave -noupdate -expand -group {DP Internal} -expand -group {Ghost Coords Out} -radix unsigned /ghost_algorithm_tb/dut/ghost_dp/ghost_x1
add wave -noupdate -expand -group {DP Internal} -expand -group {Ghost Coords Out} -radix unsigned /ghost_algorithm_tb/dut/ghost_dp/ghost_y1
add wave -noupdate -expand -group {DP Internal} -radix unsigned -childformat {{{/ghost_algorithm_tb/dut/ghost_dp/i[4]} -radix unsigned} {{/ghost_algorithm_tb/dut/ghost_dp/i[3]} -radix unsigned} {{/ghost_algorithm_tb/dut/ghost_dp/i[2]} -radix unsigned} {{/ghost_algorithm_tb/dut/ghost_dp/i[1]} -radix unsigned} {{/ghost_algorithm_tb/dut/ghost_dp/i[0]} -radix unsigned}} -subitemconfig {{/ghost_algorithm_tb/dut/ghost_dp/i[4]} {-height 15 -radix unsigned} {/ghost_algorithm_tb/dut/ghost_dp/i[3]} {-height 15 -radix unsigned} {/ghost_algorithm_tb/dut/ghost_dp/i[2]} {-height 15 -radix unsigned} {/ghost_algorithm_tb/dut/ghost_dp/i[1]} {-height 15 -radix unsigned} {/ghost_algorithm_tb/dut/ghost_dp/i[0]} {-height 15 -radix unsigned}} /ghost_algorithm_tb/dut/ghost_dp/i
add wave -noupdate -expand -group {DP Internal} /ghost_algorithm_tb/dut/ghost_dp/up_works
add wave -noupdate -expand -group {DP Internal} /ghost_algorithm_tb/dut/ghost_dp/down_works
add wave -noupdate -expand -group {DP Internal} /ghost_algorithm_tb/dut/ghost_dp/left_works
add wave -noupdate -expand -group {DP Internal} /ghost_algorithm_tb/dut/ghost_dp/right_works
add wave -noupdate /ghost_algorithm_tb/dut/mp_rm/address
add wave -noupdate /ghost_algorithm_tb/dut/mp_rm/clock
add wave -noupdate /ghost_algorithm_tb/dut/mp_rm/q
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4596 ps} 0}
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
WaveRestoreZoom {3950 ps} {4950 ps}
