module in_rect_bounds(curr_point, top_left, bottom_right, is_in);
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

    assign is_in = (((curr_x == x0) | (curr_x == x1)) & curr_y > y0 & curr_y < y1) | (((curr_y == y0) | (curr_y == y1)) & curr_x > x0 & curr_x < x1);
endmodule

module map_initializer(clk, reset, map_rom);
    input logic clk, reset;
    output logic [37:0] map_rom [20:0];

    logic [4:0] map_init_counter;
    logic [37:0] curr_rect;
    enum {S_start, S_buffer, S_done} ps, ns;

    map_rom map (map_init_counter, clk, curr_rect);

    always_comb begin
        case(ps)
            S_start: ns = map_init_counter == 21 ? S_done : S_buffer; 
            S_buffer: ns = S_start;
            S_done: ns = S_done;
        endcase
    end

    always_ff @(posedge clk) begin
        if(reset) begin
            ps <= S_start;
            map_init_counter <= 0;
        end else begin
            ps <= ns;
        end
        if(ps == S_buffer) begin
            map_rom[map_init_counter] <= curr_rect;
            map_init_counter <= map_init_counter + 1'b1;
        end
    end

endmodule