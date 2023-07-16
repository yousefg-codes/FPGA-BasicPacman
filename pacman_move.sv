module pacman_move (clk, reset, n8_left, n8_right, n8_up, n8_down, pacman_top_left, pacman_bottom_right);
    input logic clk, reset, n8_left, n8_right, n8_up, n8_down;

    output logic [18:0] pacman_top_left, pacman_bottom_right;
    logic i_done, init_regs_and_move, incr_i, check_collisions, viable_move;
    logic [4:0] rect_addr;
    logic [37:0] curr_rect;

    map_rom mp_rm (rect_addr, clk, curr_rect);
    pacman_move_ctrl pacman_ctrl (.*);
    pacman_move_dp pacman_dp (.*);
endmodule

module pacman_move_ctrl (clk, reset, i_done, init_regs_and_move, incr_i, check_collisions, viable_move);
    input logic clk, reset, i_done;
    output logic init_regs_and_move, incr_i, check_collisions, viable_move;

    enum {S_init, S_loop, S_buffer} ps, ns;

    always_comb begin
        case(ps)
            S_init: ns = S_loop;
            S_loop: ns = i_done ? S_init : S_buffer;
            S_buffer: ns = S_loop;
        endcase
    end

    assign init_regs_and_move = (ps == S_init);
    assign incr_i = (ps == S_buffer);
    assign check_collisions = (ps == S_buffer);
    assign viable_move = (ps == S_loop) & (i_done);

    always_ff @(posedge clk) begin
        if(reset) begin
            ps <= S_init;
        end else begin
            ps <= ns;
        end
    end
endmodule

module pacman_move_dp (clk, reset, n8_left, n8_right, n8_up, n8_down, init_regs_and_move, incr_i, check_collisions, viable_move, curr_rect, i_done, rect_addr, pacman_top_left, pacman_bottom_right);
    input logic clk, reset, init_regs_and_move, incr_i, n8_left, n8_right, n8_up, n8_down, check_collisions, viable_move;
    input logic [37:0] curr_rect;
    
    output logic i_done;
    output logic [4:0] rect_addr;
    output logic [18:0] pacman_top_left, pacman_bottom_right;

    logic [9:0] x0, x1, pacman_x0, pacman_x1;
    logic [8:0] y0, y1, pacman_y0, pacman_y1;
	enum {MOVE_UP, MOVE_DOWN, MOVE_LEFT, MOVE_RIGHT, STILL} movement_sel;
    logic up_works, down_works, left_works, right_works;
    logic [4:0] i;

    assign rect_addr = i;
    assign x0 = curr_rect[37:28];
    assign y0 = curr_rect[27:19];
    assign x1 = curr_rect[18:9];
    assign y1 = curr_rect[8:0];

    assign pacman_top_left = {pacman_x0, pacman_y0};
    assign pacman_bottom_right = {pacman_x1, pacman_y1};
    assign i_done = (i == 21);
    
    
    always_ff @(posedge clk) begin
        if(reset) begin
            pacman_x0 <= 10'd240;
            pacman_y0 <= 9'd300; 
            pacman_x1 <= 10'd265;
            pacman_y1 <= 9'd325;
			movement_sel <= STILL;
        end
        if (init_regs_and_move) begin
            i <= 0;
            up_works <= 1;
            down_works <= 1; 
            left_works <= 1;
            right_works <= 1;
            case(movement_sel)
				MOVE_RIGHT: begin
					pacman_x1 <= pacman_x1 + 1;
					pacman_x0 <= pacman_x0 + 1;
					pacman_y0 <= pacman_y0;
					pacman_y1 <= pacman_y1;
				end 
				MOVE_UP: begin
					pacman_y0 <= pacman_y0 + -1*1;
					pacman_y1 <= pacman_y1 + -1*1;
					pacman_x1 <= pacman_x1;
					pacman_x0 <= pacman_x0;
				end 
				MOVE_LEFT: begin
					pacman_x1 <= pacman_x1 + -1*1;
					pacman_x0 <= pacman_x0 + -1*1;
					pacman_y0 <= pacman_y0;
					pacman_y1 <= pacman_y1;
				end
				MOVE_DOWN: begin
					pacman_y0 <= pacman_y0 + 1;
					pacman_y1 <= pacman_y1 + 1;
					pacman_x1 <= pacman_x1;
					pacman_x0 <= pacman_x0;
				end
				default: begin
					pacman_y0 <= pacman_y0;
					pacman_y1 <= pacman_y1;
					pacman_x1 <= pacman_x1;
					pacman_x0 <= pacman_x0;
				end
			endcase
        end
        if(incr_i) begin
            i <= i + 1;
        end
        if (check_collisions) begin
            up_works <= up_works & ~(pacman_x0 >= x0 & pacman_x0 <= x1 & pacman_y0 + -1*1 >= y0 & pacman_y0 + -1*1 <= y1) & ~(pacman_x0 + 25 >= x0 & pacman_x0 + 25 <= x1 & pacman_y0 + -1*1 >= y0 & pacman_y0 + -1*1 <= y1);
            down_works <= down_works & ~(pacman_x1 >= x0 & pacman_x1 <= x1 & pacman_y1 + 1 >= y0 & pacman_y1 + 1 <= y1) & ~(pacman_x1 + -1*25 >= x0 & pacman_x1 + -1*25 <= x1 & pacman_y1 + 1 >= y0 & pacman_y1 + 1 <= y1);
            left_works <= left_works & ~(pacman_x0 + -1*1 >= x0 & pacman_x0 + -1*1 <= x1 & pacman_y0 >= y0 & pacman_y0 <= y1) & ~(pacman_x0 + -1*1 >= x0 & pacman_x0 + -1*1 <= x1 & pacman_y0 + 25 >= y0 & pacman_y0 + 25 <= y1);
            right_works <= right_works & ~(pacman_x1 + 1 >= x0 & pacman_x1 + 1 <= x1 & pacman_y1 >= y0 & pacman_y1 <= y1) & ~(pacman_x1 + 1 >= x0 & pacman_x1 + 1 <= x1 & pacman_y1 + -1*25 >= y0 & pacman_y1 + -1*25 <= y1);
        end
        if(viable_move) begin
            if(n8_right) begin
				if (right_works) begin
                	movement_sel <= MOVE_RIGHT;
				end else begin
					movement_sel <= STILL;
				end
            end else if (n8_up) begin
				if (up_works) begin
                	movement_sel <= MOVE_UP;
				end else begin
					movement_sel <= STILL;
				end
            end else if(n8_left) begin
				if (left_works) begin
                	movement_sel <= MOVE_LEFT;
				end else begin
					movement_sel <= STILL;
				end
            end else if (n8_down) begin
				if (down_works) begin
                	movement_sel <= MOVE_DOWN;
				end else begin
					movement_sel <= STILL;
				end
			end else begin
    			case(movement_sel)
    				MOVE_RIGHT: begin
                        if (right_works) begin
                        	movement_sel <= MOVE_RIGHT;
        				end else begin
        					movement_sel <= STILL;
        				end
    				end 
    				MOVE_UP: begin
                        if (up_works) begin
                        	movement_sel <= MOVE_UP;
        				end else begin
        					movement_sel <= STILL;
        				end
    				end 
    				MOVE_LEFT: begin
                        if (left_works) begin
                        	movement_sel <= MOVE_LEFT;
        				end else begin
        					movement_sel <= STILL;
        				end
    				end
    				MOVE_DOWN: begin
                        if (down_works) begin
                        	movement_sel <= MOVE_DOWN;
        				end else begin
        					movement_sel <= STILL;
        				end
    				end
    				default: begin
                        movement_sel <= STILL;
    				end
    			endcase
			end
        end
    end
endmodule