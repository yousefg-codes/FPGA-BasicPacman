# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./altera_up_avalon_video_vga_timing.v"
vlog "./CLOCK25_PLL/CLOCK25_PLL_0002.v"
vlog "./CLOCK25_PLL.v"
vlog "./video_driver.sv"
# vlog "./DE1_SoC.sv"
vlog "lab6_tb.sv"
vlog "map_drawer.sv"
vlog "map_rom.v"
vlog "ghost_rom.v"
vlog "ghost_algorithm.sv"
vlog "sprite_drawer.sv"
vlog "coin_image_rom.v"
vlog "coin_locations_rom.v"
vlog "pacman_rom.v"
vlog "pacman_move.sv"
vlog "coin_drawer.sv"
vlog "coin_image_rom.v"
vlog "you_won_rom.v"
vlog "coin_locations_rom.v"
vlog "n8_driver.sv"

# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
vsim -voptargs="+acc" -t 1ps -lib work ghost_algorithm_tb -Lf altera_lnsim_ver -Lf altera_mf_ver

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do ghost_algorithm_tb_wave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
