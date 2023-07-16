module in_rect(curr_point, top_left, bottom_right, is_in);
    input logic [18:0] curr_point, top_left, bottom_right;
    output logic is_in;

    logic [9:0] curr_x, x0, x1;
    logic [8:0] curr_y, y0, y1;

    assign curr_x = curr_point[18:9];
    assign x0 = top_left[18:9];
    assign x1 = bottom_right[18:9];
    assign curr_y = curr_point[8:0];
    assign y0 = top_left[8:0];
    assign y1 = bottom_right[8:0];

    assign is_in = (curr_x > x0 & curr_x < x1 & curr_y > y0 & curr_y < y1);
    
endmodule

module mux_color (clk, obj_type, curr_pos, ghost_pos, pacman_pos, coin_positions, coin_sel, coin_visible, r, g, b);
	input logic clk;
	input logic [2:0] obj_type;
	input logic [18:0] curr_pos, ghost_pos, pacman_pos;
    input logic [37:0] coin_positions [3:0];
    input logic [1:0] coin_sel;
    input logic [3:0] coin_visible;
	output logic [7:0] r, g, b;
    
	logic [23:0] ghost_rgb, pacman_rgb, coin_rgb, you_won_rgb;
	logic [7:0] ghost_r, ghost_g, ghost_b, pacman_r, pacman_g, pacman_b, coin_r, coin_g, coin_b, you_won_r, you_won_g, you_won_b;

	assign {ghost_r, ghost_g, ghost_b} = ghost_rgb;
	assign {pacman_r, pacman_g, pacman_b} = pacman_rgb;
    assign {coin_r, coin_g, coin_b} = coin_rgb;
	assign {you_won_r, you_won_g, you_won_b} = you_won_rgb;

	ghost_rom ghost ((curr_pos[18:9] + -1 * ghost_pos[18:9]) + (curr_pos[8:0] + -1 * ghost_pos[8:0])*25, clk, ghost_rgb);
	pacman_rom pacman ((curr_pos[18:9] + -1 * pacman_pos[18:9]) + (curr_pos[8:0] + -1 * pacman_pos[8:0])*25, clk, pacman_rgb);
    coin_image_rom coin ((curr_pos[18:9] + -1 * coin_positions[coin_sel][37:28]) + (curr_pos[8:0] + -1 * coin_positions[coin_sel][27:19])*15, clk, coin_rgb);
	you_won_rom won_screen ((curr_pos[18:9] + -1 * 160) + (curr_pos[8:0] + -1 * 216)*320, clk, you_won_rgb);

	always_comb begin
		if(coin_visible != 0) begin
			case(obj_type)
				3'b000: begin 
					r = 10; g = 10; b = 165;
				end
				3'b010: begin
					r = ghost_r; g = ghost_g; b = ghost_b;
				end
				3'b011: begin
					r = pacman_r; g = pacman_g; b = pacman_b;
				end
				3'b100: begin
					if(coin_visible[coin_sel]) begin
						r = coin_r; g = coin_g; b = coin_b;
					end else begin
						r = 0; g = 0; b = 0;
					end
				end
				default: begin 
						r = 0; g = 0; b = 0;
				end
			endcase
		end else begin
			if ((curr_pos[18:9] >= 160 & curr_pos[18:9] <= 480) & (curr_pos[8:0] >= 216 & curr_pos[8:0] <= 263)) begin
				r = you_won_r; g = you_won_g; b = you_won_b;
			end else begin
				r = 0; g = 0; b = 0;
			end
		end
	end
endmodule