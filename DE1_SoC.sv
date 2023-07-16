module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, LEDR, V_GPIO,
					 CLOCK_50, VGA_R, VGA_G, VGA_B, VGA_BLANK_N, VGA_CLK, VGA_HS, VGA_SYNC_N, VGA_VS);
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;

	input CLOCK_50;
	inout logic [35:0] V_GPIO;
	output [7:0] VGA_R;
	output [7:0] VGA_G;
	output [7:0] VGA_B;
	output VGA_BLANK_N;
	output VGA_CLK;
	output VGA_HS;
	output VGA_SYNC_N;
	output VGA_VS;

	logic reset, reset_display;
	logic [9:0] x;
	logic [8:0] y;
	logic [7:0] r, g, b;
	logic [31:0] divided_clocks;
	logic up, down, left, right;

	parameter picked_clock = 13;
	
	n8_driver controller_driver (.clk(CLOCK_50), .data_in(V_GPIO[28]), .latch(V_GPIO[26]), .pulse(V_GPIO[27]), .up, .down, .left, .right, .start(reset));

	clock_divider (CLOCK_50, divided_clocks);

	video_driver #(.WIDTH(640), .HEIGHT(480))
		v1 (.CLOCK_50, .reset(reset_display), .x, .y, .r, .g, .b,
			 .VGA_R, .VGA_G, .VGA_B, .VGA_BLANK_N,
			 .VGA_CLK, .VGA_HS, .VGA_SYNC_N, .VGA_VS);
	
	logic [20:0] rect_is_in;
	logic [2:0] curr_obj_type; 
	logic [37:0] map_rom [20:0]; 
	logic [37:0] coin_rom [3:0];
	logic [3:0] coin_in;
	logic [3:0] coin_visible;
	logic [1:0] coin_sel;
	logic [19:0] ghost_top_left, ghost_bottom_right, pacman_top_left, pacman_bottom_right; 
	logic in_ghost, in_pacman; 
	logic kill_pac;
	logic reset_reg, n8_left_reg, n8_right_reg, n8_down_reg, n8_up_reg;

	always_comb begin
		case(coin_in)
			4'b0001: coin_sel = 0;
			4'b0010: coin_sel = 1;
			4'b0100: coin_sel = 2;
			4'b1000: coin_sel = 3;
			default: coin_sel = 0;
		endcase
	end

	map_initializer map_init (CLOCK_50, reset, map_rom);
	coin_initializer coin_init (CLOCK_50, reset, coin_rom);
	mux_color m_color (CLOCK_50, |rect_is_in ? 0 : in_ghost ? 3'b010 : in_pacman ? 3'b011 : |coin_in ? 3'b100 : 3'b111, {x, y}, ghost_top_left, pacman_top_left, coin_rom, coin_sel, coin_visible, r, g, b);

	genvar i;
    generate
        for (i=0; i < 21; i++) begin : rects
			in_rect_bounds recti ({x, y}, map_rom[i][37:19], map_rom[i][18:0], rect_is_in[i]);
        end
    endgenerate

	genvar j;
    generate
        for (j=0; j < 4; j++) begin : coins
			in_rect coinj ({x, y}, coin_rom[j][37:19], coin_rom[j][18:0], coin_in[j]);
			coin_pac_collision coin_collj (CLOCK_50, reset, kill_pac, coin_rom[j][37:28], coin_rom[j][27:19], pacman_top_left[18:9], pacman_top_left[8:0], coin_visible, coin_visible[j]);
        end
    endgenerate

	in_rect ghost ({x, y}, ghost_top_left, ghost_bottom_right, in_ghost);
	in_rect pacman ({x, y}, pacman_top_left, pacman_bottom_right, in_pacman);
    
    logic [18:0] ghost_tl_sync1, ghost_tl_sync2, ghost_br_sync1, ghost_br_sync2,  pac_tl_sync1, pac_tl_sync2, pac_br_sync1, pac_br_sync2;
    
	ghost_algorithm ghost_algo (divided_clocks[picked_clock], reset_reg, pacman_top_left[18:9], pacman_top_left[8:0], ghost_tl_sync1, ghost_br_sync1, kill_pac);
	pacman_move pacman_movement (divided_clocks[picked_clock], reset_reg | kill_pac, left, right, up, down, pac_tl_sync1, pac_br_sync1);
	
	always_ff @(posedge CLOCK_50) begin
		reset_reg <= reset;
		n8_left_reg <= left;
		n8_right_reg <= right;
		n8_down_reg <= down;
		n8_up_reg <= up;
		ghost_tl_sync2 <= ghost_tl_sync1;
		ghost_br_sync2 <= ghost_br_sync1;
		pac_tl_sync2 <= pac_tl_sync1;
		pac_br_sync2 <= pac_br_sync1;
		pacman_top_left <= pac_tl_sync2;
		pacman_bottom_right <= pac_br_sync2;
		ghost_top_left <= ghost_tl_sync2;
		ghost_bottom_right <= ghost_br_sync2;
		if(reset) begin
			curr_obj_type <= 3'b111;
		end
	end
	
	assign HEX0 = '1;
	assign HEX1 = '1;
	assign HEX2 = '1;
	assign HEX3 = '1;
	assign HEX4 = '1;
	assign HEX5 = '1;
	assign reset_display = 0;
	
endmodule  // DE1_SoC

// The clock_divider allows us to slow the clock down so that we can
// see the lines drawn in when the animation plays on the
// VGA display.
module clock_divider (clock, divided_clocks); 
   input  logic        clock; 
   output logic [31:0] divided_clocks; 
 
   initial 
      divided_clocks = 0; 
 
   always_ff @(posedge clock) 
      divided_clocks <= divided_clocks + 1; 
endmodule  // clock_divider