module coin_pac_collision (clk, reset, pac_killed, coin_left_x, coin_top_y, pacman_left_x, pacman_top_y, coin_visible, is_visible);
	input logic clk, reset, pac_killed;
	input logic [9:0] coin_left_x, pacman_left_x;
	input logic [8:0] coin_top_y, pacman_top_y;
	input logic [3:0] coin_visible;

	output logic is_visible;
    
    always_ff @(posedge clk) begin
        if(reset) begin
            is_visible <= 1;
        end else if((is_visible | pac_killed) & (coin_visible != 0)) begin
    	    is_visible = ~((coin_left_x >= pacman_left_x & coin_left_x <= pacman_left_x+25 & coin_top_y >= pacman_top_y & coin_top_y <= pacman_top_y+25) 
                            | (coin_left_x + 15 >= pacman_left_x & coin_left_x + 15 <= pacman_left_x+25 & coin_top_y >= pacman_top_y & coin_top_y <= pacman_top_y+25)
                            | (coin_left_x >= pacman_left_x & coin_left_x <= pacman_left_x+25 & coin_top_y+15 >= pacman_top_y & coin_top_y+15 <= pacman_top_y+25)
                            | (coin_left_x + 15 >= pacman_left_x & coin_left_x + 15 <= pacman_left_x+25 & coin_top_y+15 >= pacman_top_y & coin_top_y+15 <= pacman_top_y+25));
        end else begin
            is_visible <= 0;
        end
    end
endmodule

module coin_initializer(clk, reset, coin_rom);
    input logic clk, reset;
    output logic [37:0] coin_rom [3:0];

    logic [2:0] coin_init_counter;
    logic [37:0] curr_coin;
    enum {S_start, S_buffer, S_done} ps, ns;

    coin_locations_rom coin_locs (coin_init_counter, clk, curr_coin);

    always_comb begin
        case(ps)
            S_start: ns = coin_init_counter == 4 ? S_done : S_buffer; 
            S_buffer: ns = S_start;
            S_done: ns = S_done;
        endcase
    end

    always_ff @(posedge clk) begin
        if(reset) begin
            ps <= S_start;
            coin_init_counter <= 0;
        end else begin
            ps <= ns;
        end
        if(ps == S_buffer) begin
            coin_rom[coin_init_counter] <= curr_coin;
            coin_init_counter <= coin_init_counter + 1'b1;
        end
    end

endmodule