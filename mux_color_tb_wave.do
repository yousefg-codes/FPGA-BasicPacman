onerror {resume}
quietly virtual function -install /mux_color_tb -env /mux_color_tb/dut { &{/mux_color_tb/r, /mux_color_tb/g, /mux_color_tb/b }} RGB_COMB
quietly WaveActivateNextPane {} 0
add wave -noupdate /mux_color_tb/clk
add wave -noupdate -radix unsigned /mux_color_tb/RGB_COMB
add wave -noupdate -radix unsigned /mux_color_tb/r
add wave -noupdate -radix unsigned /mux_color_tb/g
add wave -noupdate -radix unsigned /mux_color_tb/b
add wave -noupdate /mux_color_tb/obj_type
add wave -noupdate /mux_color_tb/curr_pos
add wave -noupdate /mux_color_tb/ghost_pos
add wave -noupdate /mux_color_tb/pacman_pos
add wave -noupdate -radix unsigned /mux_color_tb/dut/ghost_rgb
add wave -noupdate -radix unsigned /mux_color_tb/dut/coin_rgb
add wave -noupdate /mux_color_tb/dut/pacman_rgb
add wave -noupdate /mux_color_tb/dut/you_won_rgb
add wave -noupdate -childformat {{{/mux_color_tb/coin_rom[3]} -radix unsigned} {{/mux_color_tb/coin_rom[2]} -radix unsigned} {{/mux_color_tb/coin_rom[1]} -radix unsigned} {{/mux_color_tb/coin_rom[0]} -radix unsigned}} -subitemconfig {{/mux_color_tb/coin_rom[3]} {-height 15 -radix unsigned} {/mux_color_tb/coin_rom[2]} {-height 15 -radix unsigned} {/mux_color_tb/coin_rom[1]} {-height 15 -radix unsigned} {/mux_color_tb/coin_rom[0]} {-height 15 -radix unsigned}} /mux_color_tb/coin_rom
add wave -noupdate /mux_color_tb/coin_sel
add wave -noupdate /mux_color_tb/coin_visible
add wave -noupdate /mux_color_tb/i
add wave -noupdate /mux_color_tb/j
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
