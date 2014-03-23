module character_display( clk, en, reset, buttons, status_leds, disp_red, disp_green, disp_blue, disp_clk, disp_en, disp_vsync, disp_hsync );

input wire clk;
input wire en, reset;
input wire [ 2: 0 ] buttons;

output wire [ 9: 0 ] status_leds;
output wire [ 7: 0 ] disp_red, disp_green, disp_blue;
output wire disp_clk, disp_en, disp_vsync, disp_hsync;

wire [ 9: 0 ] horz_pos, vert_pos; // 10-bit draw position
reg [ 7: 0 ] red_int, green_int, blue_int; // Internal 8-bit color values for the vga_controller

assign disp_en = en;

wire valid_draw;
reg [ 7: 0 ] next_red_int, next_green_int, next_blue_int;

pll9mhz disp_clk_pll ( .inclk0( clk ), .c0( disp_clk ), .locked() );

vga_controller controller ( .clk( clk ), .disp_clk( disp_clk ), .en( en ), .red_in( red_int ), .green_in( green_int ), .blue_in( blue_int ),
                            .valid_draw( valid_draw ), .h_pos( horz_pos ), .v_pos( vert_pos ),
                            .red_out( disp_red ), .green_out( disp_green ), .blue_out( disp_blue ),
                            .disp_hsync( disp_hsync ), .disp_vsync( disp_vsync ) );

always @( * ) begin
    if ( valid_draw ) begin
        next_red_int <= horz_pos[ 7: 0 ];
        next_green_int <= vert_pos[ 7: 0 ];
        next_blue_int <= 8'h8e;
    end
    else begin
        next_red_int <= 1'b0;
        next_green_int <= 1'b0;
        next_blue_int <= 1'b0;
    end
end

always @( posedge disp_clk ) begin
    red_int <= next_red_int;
    green_int <= next_green_int;
    blue_int <= next_blue_int;
end

endmodule
