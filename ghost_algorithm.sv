module ghost_algorithm(clk, reset, pacman_left_x, pacman_top_y, ghost_top_left, ghost_bottom_right, kill_pac);
    input logic clk, reset;
    input logic [9:0] pacman_left_x;
    input logic [8:0] pacman_top_y;
    
    output logic [18:0] ghost_top_left, ghost_bottom_right;
    output logic kill_pac;
    
    logic i_done,calc_diff, init_regs, incr_i, check_collisions, viable_move;
    logic [4:0] rect_addr;
    logic [37:0] curr_rect;

    map_rom mp_rm (rect_addr, clk, curr_rect);
    ghost_algorithm_ctrl ghost_ctrl (.*);
    ghost_algorithm_dp ghost_dp (.*);
endmodule

module ghost_algorithm_ctrl(clk, reset, i_done, calc_diff, init_regs, incr_i, check_collisions, viable_move);
    input logic clk, reset, i_done;
    output logic calc_diff, init_regs, incr_i, check_collisions, viable_move;

    enum {S_init, S_loop, S_buffer} ps, ns;

    always_comb begin
        case(ps)
            S_init: ns = S_loop;
            S_loop: ns = i_done ? S_init : S_buffer;
            S_buffer: ns = S_loop;
        endcase
    end

    assign calc_diff = (ps == S_init);
    assign init_regs = (ps == S_init);
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

module ghost_algorithm_dp(clk, reset, calc_diff, init_regs, incr_i, check_collisions, viable_move, curr_rect, pacman_left_x, pacman_top_y, i_done, rect_addr, ghost_top_left, ghost_bottom_right, kill_pac);
    input logic clk, reset, calc_diff, init_regs, incr_i, check_collisions, viable_move;
    input logic [37:0] curr_rect;
    input logic [9:0] pacman_left_x;
    input logic [8:0] pacman_top_y;
    
    output logic i_done, kill_pac;
    output logic [4:0] rect_addr;
    output logic [18:0] ghost_top_left, ghost_bottom_right;

    logic signed [10:0] dX;
    logic signed [9:0] dY;
    logic [9:0] x0, x1, ghost_x0, ghost_x1;
    logic [8:0] y0, y1, ghost_y0, ghost_y1;
    logic up_works, down_works, left_works, right_works;
    logic [4:0] i;
    logic is_x_obstructed, is_y_obstructed, priority_y, priority_x;

    assign rect_addr = i;
    assign x0 = curr_rect[37:28];
    assign y0 = curr_rect[27:19];
    assign x1 = curr_rect[18:9];
    assign y1 = curr_rect[8:0];

    assign ghost_top_left = {ghost_x0, ghost_y0};
    assign ghost_bottom_right = {ghost_x1, ghost_y1};
    assign i_done = (i == 21);
    
    always_ff @(posedge clk) begin
        if(reset) begin
            ghost_x0 <= 10'd92;
            ghost_y0 <= 9'd100; 
            ghost_x1 <= 10'd117;
            ghost_y1 <= 9'd125;
            is_x_obstructed <= 0;
            is_y_obstructed <= 0;
        end
        if (calc_diff) begin
            kill_pac <= 0;
            dX <= ghost_top_left[18:9] - pacman_left_x;
            dY <= ghost_top_left[8:0] - pacman_top_y;
        end
        if (init_regs) begin
            i <= 0;
            up_works <= 1;
            down_works <= 1; 
            left_works <= 1;
            right_works <= 1;
            if(is_x_obstructed) begin
                if (up_works) begin
                    ghost_y0 <= ghost_y0 + -1*1;
                    ghost_y1 <= ghost_y1 + -1*1;
                end else if (down_works) begin
                    ghost_y0 <= ghost_y0 + 1;
                    ghost_y1 <= ghost_y1 + 1;
                end
            end else if (is_y_obstructed) begin
                if(right_works) begin
                    ghost_x1 <= ghost_x1 + 1;
                    ghost_x0 <= ghost_x0 + 1;
                end else if (left_works) begin
                    ghost_x1 <= ghost_x1 + -1*1;
                    ghost_x0 <= ghost_x0 + -1*1;
                end
            end
        end
        if(incr_i) begin
            i <= i + 1;
        end
        if (check_collisions) begin
            kill_pac <= (ghost_x0 >= pacman_left_x & ghost_x0 <= pacman_left_x+25 & ghost_y0 >= pacman_top_y & ghost_y0 <= pacman_top_y+25) 
                        | (ghost_x0 + 25 >= pacman_left_x & ghost_x0 + 25 <= pacman_left_x+25 & ghost_y0 >= pacman_top_y & ghost_y0 <= pacman_top_y+25)
                        | (ghost_x0 >= pacman_left_x & ghost_x0 <= pacman_left_x+25 & ghost_y0+25 >= pacman_top_y & ghost_y0+25 <= pacman_top_y+25)
                        | (ghost_x0 + 25 >= pacman_left_x & ghost_x0 + 25 <= pacman_left_x+25 & ghost_y0+25 >= pacman_top_y & ghost_y0+25 <= pacman_top_y+25);
            up_works <= up_works & ~(ghost_x0 >= x0 & ghost_x0 <= x1 & ghost_y0 + -1*1 >= y0 & ghost_y0 + -1*1 <= y1) & ~(ghost_x0 + 25 >= x0 & ghost_x0 + 25 <= x1 & ghost_y0 + -1*1 >= y0 & ghost_y0 + -1*1 <= y1);
            down_works <= down_works & ~(ghost_x1 >= x0 & ghost_x1 <= x1 & ghost_y1 + 1 >= y0 & ghost_y1 + 1 <= y1) & ~(ghost_x1 + -1*25 >= x0 & ghost_x1 + -1*25 <= x1 & ghost_y1 + 1 >= y0 & ghost_y1 + 1 <= y1);
            left_works <= left_works & ~(ghost_x0 + -1*1 >= x0 & ghost_x0 + -1*1 <= x1 & ghost_y0 >= y0 & ghost_y0 <= y1) & ~(ghost_x0 + -1*1 >= x0 & ghost_x0 + -1*1 <= x1 & ghost_y0 + 25 >= y0 & ghost_y0 + 25 <= y1);
            right_works <= right_works & ~(ghost_x1 + 1 >= x0 & ghost_x1 + 1 <= x1 & ghost_y1 >= y0 & ghost_y1 <= y1) & ~(ghost_x1 + 1 >= x0 & ghost_x1 + 1 <= x1 & ghost_y1 + -1*25 >= y0 & ghost_y1 + -1*25 <= y1);
        end
        if(viable_move) begin
            if(~(is_x_obstructed | is_y_obstructed)) begin
                if (priority_y) begin
                    if(dX != 0 & dX[10] & right_works) begin
                        ghost_x1 <= ghost_x1 + 1;
                        ghost_x0 <= ghost_x0 + 1;
                    end else if (dY != 0 & dY[9] & down_works) begin
                        ghost_y0 <= ghost_y0 + 1;
                        ghost_y1 <= ghost_y1 + 1;
                    end else if(dX != 0 & ~dX[10] & left_works) begin
                        ghost_x1 <= ghost_x1 + -1*1;
                        ghost_x0 <= ghost_x0 + -1*1;
                    end else if (dY != 0 & ~dY[9] & up_works) begin
                        ghost_y0 <= ghost_y0 + -1*1;
                        ghost_y1 <= ghost_y1 + -1*1;
                    end else begin
                        is_x_obstructed <= dY == 0;
                        is_y_obstructed <= dX == 0;
                    end
                end else if (priority_x) begin
                    if(dX != 0 & dX[10] & right_works) begin
                        ghost_x1 <= ghost_x1 + 1;
                        ghost_x0 <= ghost_x0 + 1;
                    end else if(dX != 0 & ~dX[10] & left_works) begin
                        ghost_x1 <= ghost_x1 + -1*1;
                        ghost_x0 <= ghost_x0 + -1*1;
                    end else if (dY != 0 & ~dY[9] & up_works) begin
                        ghost_y0 <= ghost_y0 + -1*1;
                        ghost_y1 <= ghost_y1 + -1*1;
                    end else if (dY != 0 & dY[9] & down_works) begin
                        ghost_y0 <= ghost_y0 + 1;
                        ghost_y1 <= ghost_y1 + 1;
                    end else begin
                        is_x_obstructed <= dY == 0;
                        is_y_obstructed <= dX == 0;
                    end
                end else begin
                    if(dX != 0 & dX[10] & right_works) begin
                        ghost_x1 <= ghost_x1 + 1;
                        ghost_x0 <= ghost_x0 + 1;
                    end else if (dY != 0 & ~dY[9] & up_works) begin
                        ghost_y0 <= ghost_y0 + -1*1;
                        ghost_y1 <= ghost_y1 + -1*1;
                    end else if(dX != 0 & ~dX[10] & left_works) begin
                        ghost_x1 <= ghost_x1 + -1*1;
                        ghost_x0 <= ghost_x0 + -1*1;
                    end else if (dY != 0 & dY[9] & down_works) begin
                        ghost_y0 <= ghost_y0 + 1;
                        ghost_y1 <= ghost_y1 + 1;
                    end else begin
                        is_x_obstructed <= dY == 0;
                        is_y_obstructed <= dX == 0;
                    end
                end
            end else begin
                if(is_x_obstructed) begin
                    is_x_obstructed <= ~((dX != 0 & ~dX[10] & left_works) | (dX != 0 & dX[10] & right_works));
                    if (~((dX != 0 & ~dX[10] & left_works) | (dX != 0 & dX[10] & right_works))) begin
                        priority_x <= 1;
                        priority_y <= 0;
                    end
                end else if(is_y_obstructed) begin
                    is_y_obstructed <= ~((dY != 0 & dY[9] & down_works) | (dY != 0 & ~dY[9] & up_works));
                    if (~((dY != 0 & dY[9] & down_works) | (dY != 0 & ~dY[9] & up_works))) begin
                        priority_x <= 0;
                        priority_y <= 1;
                    end
                end
            end
        end
    end
endmodule