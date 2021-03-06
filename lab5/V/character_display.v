module character_display( clk, en, reset, buttons, switches, status_leds, disp_red, disp_green, disp_blue, disp_clk, disp_en, disp_vsync, disp_hsync );

input wire clk;
input wire en, reset;
input wire [ 2: 0 ] buttons;
input wire [ 6: 0 ] switches;

output wire [ 9: 0 ] status_leds;
output wire [ 7: 0 ] disp_red, disp_green, disp_blue;
output wire disp_clk, disp_en, disp_vsync, disp_hsync;

wire [ 9: 0 ] horz_pos, vert_pos; // 10-bit draw position
reg clr;
wire [ 7: 0 ] red_int, green_int, blue_int; // Internal 8-bit color values for the vga_controller

assign disp_en = en;
assign status_leds = { switches, buttons }; // Just too see things scroll

wire valid_draw;

pll9mhz disp_clk_pll ( .inclk0( clk ), .c0( disp_clk ), .locked() );

vga_controller controller ( .clk( clk ), .disp_clk( disp_clk ), .en( en ), .red_in( red_int ), .green_in( green_int ), .blue_in( blue_int ),
                            .valid_draw( valid_draw ), .h_pos( horz_pos ), .v_pos( vert_pos ),
                            .red_out( disp_red ), .green_out( disp_green ), .blue_out( disp_blue ),
                            .disp_hsync( disp_hsync ), .disp_vsync( disp_vsync ) );

// font generation circuit instantiation
character_storage storage ( .clk( clk ), .video_on( valid_draw ), .pixel_x( horz_pos ), .pixel_y( vert_pos ),
                            .red_out( red_int ), .green_out( green_int ), .blue_out( blue_int ), .reset( reset ), .btn( buttons ), .sw( switches ) );


endmodule
