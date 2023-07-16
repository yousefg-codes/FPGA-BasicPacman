onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /map_drawer_tb/clk
add wave -noupdate /map_drawer_tb/reset
add wave -noupdate /map_drawer_tb/start
add wave -noupdate /map_drawer_tb/done
add wave -noupdate -radix unsigned /map_drawer_tb/r
add wave -noupdate -radix unsigned /map_drawer_tb/g
add wave -noupdate -radix unsigned /map_drawer_tb/b
add wave -noupdate -radix unsigned /map_drawer_tb/x
add wave -noupdate -radix unsigned /map_drawer_tb/y
add wave -noupdate /map_drawer_tb/map/map_ctrl_unit/ps
add wave -noupdate -expand -group ROM -radix unsigned /map_drawer_tb/map/curr_rect
add wave -noupdate -expand -group ROM -radix unsigned /map_drawer_tb/map/rect_addr
add wave -noupdate -expand -group Control /map_drawer_tb/map/load_rect
add wave -noupdate -expand -group Control /map_drawer_tb/map/get_next_rect
add wave -noupdate -expand -group Control /map_drawer_tb/map/incr_i
add wave -noupdate -expand -group Control /map_drawer_tb/map/load_j
add wave -noupdate -expand -group Control /map_drawer_tb/map/update_j
add wave -noupdate -expand -group Control /map_drawer_tb/map/load_ss
add wave -noupdate -expand -group Control /map_drawer_tb/map/update_ss
add wave -noupdate -expand -group Status /map_drawer_tb/map/i_done
add wave -noupdate -expand -group Status /map_drawer_tb/map/j_done
add wave -noupdate -expand -group Status /map_drawer_tb/map/ss_done
add wave -noupdate -expand -group {DP Internal} -radix unsigned /map_drawer_tb/map/map_dp_unit/i
add wave -noupdate -expand -group {DP Internal} -radix unsigned /map_drawer_tb/map/map_dp_unit/j
add wave -noupdate -expand -group {DP Internal} -radix unsigned /map_drawer_tb/map/map_dp_unit/x0
add wave -noupdate -expand -group {DP Internal} -radix unsigned /map_drawer_tb/map/map_dp_unit/x1
add wave -noupdate -expand -group {DP Internal} -radix unsigned /map_drawer_tb/map/map_dp_unit/y0
add wave -noupdate -expand -group {DP Internal} -radix unsigned /map_drawer_tb/map/map_dp_unit/y1
add wave -noupdate -expand -group {DP Internal} /map_drawer_tb/map/map_dp_unit/ss
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {295 ps} 0}
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
