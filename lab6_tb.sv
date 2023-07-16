
`timescale 1 ps / 1 ps
module map_initializer_tb();
    logic clk, reset;
    logic [37:0] map_rom [20:0];

    parameter CLOCK_PERIOD = 100;

    initial begin
        clk <= 0;
        forever #(CLOCK_PERIOD/2) clk <= ~clk; #10;
    end

    map_initializer dut (.*);

    initial begin
        @(posedge clk); reset <= 1;
        @(posedge clk); reset <= 0;
        repeat(42) begin
            @(posedge clk);
        end
        $stop;
    end

endmodule

`timescale 1 ps / 1 ps
module coin_initializer_tb();
    logic clk, reset;
    logic [18:0] coin_rom [3:0];

    parameter CLOCK_PERIOD = 100;

    initial begin
        clk <= 0;
        forever #(CLOCK_PERIOD/2) clk <= ~clk; #10;
    end

    coin_initializer dut (.*);

    initial begin
        @(posedge clk); reset <= 1;
        @(posedge clk); reset <= 0;
        repeat(42) begin
            @(posedge clk);
        end
        $stop;
    end

endmodule

module rect_bounds_tb();
    logic clk, is_in;
    logic [18:0] curr_point;
    logic [37:0] bounds;

    parameter CLOCK_PERIOD = 100;

    initial begin
        clk <= 0;
        forever #(CLOCK_PERIOD/2) clk <= ~clk; #10;
    end

    in_rect_bounds dut (curr_point, bounds[37:19], bounds[18:0], is_in);

    integer i, j;    
    initial begin
        @(posedge clk); curr_point <= 0; bounds <= 2689607700; //Set bounds to (10, 10) and (20, 20)
        for (i = 9; i < 22; i++) begin
            for (j = 9; j < 22; j++) begin 
                @(posedge clk); curr_point <= {i[9:0], j[8:0]};
            end
        end
        @(posedge clk);
        $stop;
    end

endmodule

module in_rect_tb();
    logic clk, is_in;
    logic [18:0] curr_point;
    logic [37:0] bounds;

    parameter CLOCK_PERIOD = 100;

    initial begin
        clk <= 0;
        forever #(CLOCK_PERIOD/2) clk <= ~clk; #10;
    end

    in_rect dut (curr_point, bounds[37:19], bounds[18:0], is_in);

    integer i, j;    
    initial begin
        @(posedge clk); curr_point <= 0; bounds <= 2689607700; //Set bounds to (10, 10) and (20, 20)
        for (i = 9; i < 22; i++) begin
            for (j = 9; j < 22; j++) begin 
                @(posedge clk); curr_point <= {i[9:0], j[8:0]};
            end
        end
        @(posedge clk);
        $stop;
    end

endmodule

module coin_pac_collision_tb();
    logic clk, reset, pac_killed, is_visible; //Only output is is_visible (everything else is an input)
    logic [8:0] coin_top_y, pacman_top_y;
    logic [9:0] coin_left_x, pacman_left_x;
    logic [3:0] coin_visible;

    parameter CLOCK_PERIOD = 100;

    initial begin
        clk <= 0;
        forever #(CLOCK_PERIOD/2) clk <= ~clk; #10;
    end
    
    coin_pac_collision dut (clk, reset, pac_killed, coin_left_x, coin_top_y, pacman_left_x, pacman_top_y, coin_visible, is_visible);

    initial begin
        @(posedge clk); reset <= 1; pac_killed <= 0; coin_visible <= 3; coin_top_y <= 20; coin_left_x <= 20; pacman_top_y <= 40; pacman_left_x <= 40;
        @(posedge clk); reset <= 0;
        @(posedge clk);
        @(posedge clk);
        //Test collisions on all 4 corners of coin
        @(posedge clk); coin_top_y <= 20; coin_left_x <= 20; pacman_top_y <= 19; pacman_left_x <= 19;
        @(posedge clk); reset <= 1;
        @(posedge clk); reset <= 0;
        @(posedge clk); coin_top_y <= 20; coin_left_x <= 20; pacman_top_y <= 0; pacman_left_x <= 0;
        @(posedge clk); reset <= 1;
        @(posedge clk); reset <= 0;
        @(posedge clk); coin_top_y <= 20; coin_left_x <= 20; pacman_top_y <= 0; pacman_left_x <= 19;
        @(posedge clk); reset <= 1;
        @(posedge clk); reset <= 0;
        @(posedge clk); coin_top_y <= 20; coin_left_x <= 20; pacman_top_y <= 19; pacman_left_x <= 0;
        @(posedge clk);
        @(posedge clk); 
        //Test pac killed
        @(posedge clk); pac_killed <= 1;
        @(posedge clk); pac_killed <= 0;
        //Test all coins gone
        @(posedge clk); coin_visible <= 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        $stop;
    end

endmodule

// `timescale 1 ps / 1 ps
// module top_level_tb();
//     logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
// 	logic [9:0] LEDR;
// 	logic [35:0] V_GPIO;
// 	logic [9:0] SW;

// 	logic CLOCK_50;
// 	logic [7:0] VGA_R, VGA_G, VGA_B;
// 	logic VGA_BLANK_N, VGA_CLK, VGA_HS, VGA_SYNC_N, VGA_VS;

//     parameter CLOCK_PERIOD = 100;

//     initial begin
//         CLOCK_50 <= 0;
//         forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50; #10;
//     end

//     DE1_SoC dut (.*);
 
//     initial begin
//         @(posedge CLOCK_50); 
//         @(posedge CLOCK_50); 
//         repeat(42) begin
//             @(posedge CLOCK_50);
//         end
//         $stop;
//     end

// endmodule

`timescale 1 ps / 1 ps
module mux_color_tb();
    logic clk;
    logic [8:0] curr_pos_y;
    logic [9:0] curr_pos_x;
    logic [7:0] r, g, b; //Only outputs
    logic [2:0] obj_type;
    logic [18:0] curr_pos, ghost_pos, pacman_pos;
    logic [37:0] coin_rom [3:0];
    logic [3:0] coin_visible;
    logic [1:0] coin_sel;

    assign curr_pos = {curr_pos_x, curr_pos_y};

    parameter CLOCK_PERIOD = 100;

    initial begin
        clk <= 0;
        forever #(CLOCK_PERIOD/2) clk <= ~clk; #10;
    end
    
    mux_color dut (clk, obj_type, curr_pos, ghost_pos, pacman_pos, coin_rom, coin_sel, coin_visible, r, g, b);
    
    integer i, j, k;
    initial begin
        @(posedge clk); obj_type <= 3'b111; coin_visible <= 4'b1111; coin_rom[0] <= {10'd10, 9'd10}; coin_rom[1] <= {10'd10, 9'd100}; coin_rom[2] <= {10'd100, 9'd10}; coin_rom[3] <= {10'd100, 9'd100}; coin_sel <= 0;
        //Test void areas
        @(posedge clk); curr_pos_x <= curr_pos_x + 1; 
        @(posedge clk); curr_pos_x <= curr_pos_x + 1;
        @(posedge clk); curr_pos_y <= curr_pos_y + 1;
        //Test rectangle drawing
        @(posedge clk); curr_pos_x <= curr_pos_x + 1; obj_type <= 0;
        @(posedge clk); curr_pos_x <= curr_pos_x + 1;
        @(posedge clk); curr_pos_x <= curr_pos_x + 1;
        @(posedge clk); curr_pos_y <= curr_pos_y + 1;
        @(posedge clk); 
        //Test Ghost output
        @(posedge clk); obj_type <= 3'b010; ghost_pos <= {10'd10, 9'd10}; curr_pos_y <= 10; curr_pos_x <= 10;
        for (i = 10; i < 36; i++) begin
            for (j = 11; j < 36; j++) begin 
                @(posedge clk); curr_pos_x <= j; curr_pos_y <= i;
            end
        end
        @(posedge clk); 
        //Test Pacman output
        @(posedge clk); obj_type <= 3'b011; pacman_pos <= {10'd10, 9'd10}; curr_pos_y <= 10; curr_pos_x <= 10;
        for (i = 10; i < 36; i++) begin
            for (j = 10; j < 36; j++) begin 
                @(posedge clk); curr_pos_x <= j; curr_pos_y <= i;
            end
        end
        @(posedge clk); 
        //Test Coins
        @(posedge clk); obj_type <= 3'b100; pacman_pos <= {10'd10, 9'd10}; curr_pos_y <= 10; curr_pos_x <= 10; coin_visible <= 4'b0011;
        for (i = 10; i < 36; i++) begin
            for (j = 10; j < 36; j++) begin 
                @(posedge clk); coin_sel <= 0; curr_pos_x <= j; curr_pos_y <= i;
            end
        end
        @(posedge clk);
        for (i = 100; i < 126; i++) begin
            for (j = 10; j < 36; j++) begin 
                @(posedge clk); coin_sel <= 1; curr_pos_x <= j; curr_pos_y <= i;
            end
        end
        @(posedge clk);
        for (i = 10; i < 36; i++) begin
            for (j = 100; j < 126; j++) begin 
                @(posedge clk); coin_sel <= 2; curr_pos_x <= j; curr_pos_y <= i;
            end
        end
        @(posedge clk);
        for (i = 100; i < 126; i++) begin
            for (j = 100; j < 126; j++) begin 
                @(posedge clk); coin_sel <= 3; curr_pos_x <= j; curr_pos_y <= i;
            end
        end
        @(posedge clk);
        //Test "You Won" screen
        @(posedge clk); coin_visible <= 0;
        @(posedge clk); 
        for (i = 216; i < 263; i++) begin
            for (j = 160; j < 480; j++) begin 
                @(posedge clk); coin_sel <= k; curr_pos_x <= j; curr_pos_y <= i;
            end
        end
        @(posedge clk); 
        @(posedge clk); 
        $stop;
    end

endmodule

`timescale 1 ps / 1 ps
module ghost_algorithm_tb();
    logic clk, reset, kill_pac;
    logic [9:0] pacman_left_x;
    logic [8:0] pacman_top_y;
    logic [18:0] ghost_top_left, ghost_bottom_right;

    parameter CLOCK_PERIOD = 100;

    initial begin
        clk <= 0;
        forever #(CLOCK_PERIOD/2) clk <= ~clk; #10;
    end

    ghost_algorithm dut(.*); 
    
    initial begin
        @(posedge clk); reset <= 1;
        @(posedge clk); reset <= 0; pacman_left_x <= 240; pacman_top_y <= 300;
        @(posedge kill_pac); pacman_left_x <= 92; pacman_top_y <= 100;
        repeat(100000)    
            @(posedge clk); //Ghost should get stuck in a back and forth loop (intentional to reduce difficulty)
        $stop;
    end

endmodule


module pacman_move_tb();
	logic clk, reset, n8_left, n8_right, n8_up, n8_down;
	logic [18:0] pacman_top_left, pacman_bottom_right;
	
	pacman_move dut(.*);
	
	parameter CLOCK_PERIOD = 100;
	
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; #10;
	end
	
	initial begin
		@(posedge clk); reset <= 1;
		@(posedge clk); reset <= 0; n8_left <= 0; n8_right <= 0; n8_down <= 0; n8_up <= 1; // should go up.
		repeat (86)
			@(posedge clk); 
		@(posedge clk); n8_up <= 0; n8_right <= 1;  // should go right.
		repeat (86)
			@(posedge clk); 
		@(posedge clk); n8_right <= 0; n8_left <= 1;  // should go left.
		repeat (86)
			@(posedge clk);
		@(posedge clk); n8_left <= 0; n8_down <= 1; // should go down.
		repeat (86)
			@(posedge clk);
		@(posedge clk); n8_down <= 0;
        @(posedge clk);
        @(posedge clk);
		$stop;
	end
endmodule 