module vga_controller( clk, disp_clk, en, red_in, green_in, blue_in,
                       valid_draw, h_pos, v_pos, red_out, green_out, blue_out, disp_hsync, disp_vsync );

input wire clk, disp_clk; // 50MHz, 9MHz
input wire en;
input wire [ 7: 0 ] red_in, green_in, blue_in;

output reg valid_draw;
output reg [ 9: 0 ] h_pos, v_pos;
output reg [ 7: 0 ] red_out, green_out, blue_out;
output reg disp_hsync, disp_vsync;


parameter HORZ_PIXELS = 10'd480; // max (2^9-1) - (front porch + back porch + low width)
parameter VERT_PIXELS = 10'd272; // max (2^9-1) - (front porch + back porch + low width)
parameter HORZ_FRONT_PORCH = 10'd2; // pixels
parameter HORZ_BACK_PORCH = 10'd2; // pixels
parameter VERT_FRONT_PORCH = 10'd2; // horizontal lines
parameter VERT_BACK_PORCH = 10'd2; // horizontal lines
parameter HORZ_LOW_WIDTH = 10'd41; // clock cycles
parameter VERT_LOW_WIDTH = 10'd10; // horizontal lines

parameter HORZ_MIN_VALID_COUNT = HORZ_LOW_WIDTH + HORZ_FRONT_PORCH;
parameter HORZ_MAX_VALID_COUNT = HORZ_LOW_WIDTH + HORZ_FRONT_PORCH + HORZ_PIXELS;
parameter HORZ_MAX_COUNT = HORZ_LOW_WIDTH + HORZ_FRONT_PORCH + HORZ_PIXELS + HORZ_BACK_PORCH;

parameter VERT_MIN_VALID_COUNT = VERT_LOW_WIDTH + VERT_FRONT_PORCH;
parameter VERT_MAX_VALID_COUNT = VERT_LOW_WIDTH + VERT_FRONT_PORCH + VERT_PIXELS;
parameter VERT_MAX_COUNT = VERT_LOW_WIDTH + VERT_FRONT_PORCH + VERT_PIXELS + VERT_BACK_PORCH;

// HSync pattern: 525 clock cycles period; 41 low, 2 front porch, 480 data, 2 back porch
// VSync pattern: 286 lines period; 10 low, 2 front porch, 272 data, 2 pack porch

reg [ 9: 0 ] h_count, v_count; // Counters for progression through real and non-display positions
reg [ 9: 0 ] next_h_count, next_v_count;
wire h_valid, v_valid, next_valid_draw;

assign h_valid = ( h_count > HORZ_MIN_VALID_COUNT ) && ( h_count < HORZ_MAX_COUNT );
assign v_valid = ( v_count > VERT_MIN_VALID_COUNT ) && ( h_count < VERT_MAX_COUNT );
assign next_valid_draw = h_valid && v_valid;

reg next_hsync, next_vsync;

// Excitation logic
always @( * ) begin
    if ( h_count == HORZ_MAX_COUNT ) begin
        next_h_count <= 1'b0;
    end
    else begin
        next_h_count <= h_count + 1'b1; // Always count horizontal progress
    end

    if ( v_count == VERT_MAX_COUNT ) begin
        next_v_count <= 1'b0;
    end
    else if ( h_count == HORZ_MAX_COUNT ) begin
        next_v_count <= v_count + 1'b1;
    end
    else begin
        next_v_count <= v_count;
    end

    if ( h_count < HORZ_LOW_WIDTH ) begin
        next_hsync <= 1'b0;
    end
    else begin
        next_hsync <= 1'b1;
    end

    if ( v_count < VERT_LOW_WIDTH ) begin
        next_vsync <= 1'b0;
    end
    else begin
        next_vsync <= 1'b1;
    end
end

// Output logic
always @( posedge disp_clk ) begin
    if ( en ) begin
        valid_draw <= next_valid_draw;
        h_count <= next_h_count;
        v_count <= next_v_count;

        h_pos <= h_count - HORZ_MIN_VALID_COUNT;
        v_pos <= v_count - VERT_MIN_VALID_COUNT;

        disp_hsync <= next_hsync;
        disp_vsync <= next_vsync;

        red_out <= red_in;
        green_out <= green_in;
        blue_out <= blue_in;
    end
    else begin
        valid_draw <= 1'b0;
        h_count <= 1'b0;
        v_count <= 1'b0;

        h_pos <= 1'b0;
        v_pos <= 1'b0;

        disp_hsync <= 1'b0;
        disp_vsync <= 1'b0;
    end
end

endmodule
