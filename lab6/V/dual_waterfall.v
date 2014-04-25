module dual_waterfall( clk_data, clk_disp,
                       h_pos, v_pos, valid_draw,
                       low_sink_valid, low_sink_data,
                       high_sink_valid, high_sink_data,
                       disp_red, disp_green, disp_blue
                     );

input wire clk_data, clk_disp;
input wire [ 9: 0 ] h_pos, v_pos;
input wire valid_draw;

input wire low_sink_valid, high_sink_valid;
input wire [ 15: 0 ] low_sink_data, high_sink_data;

output reg [ 7: 0 ] disp_red, disp_green, disp_blue;

column_framebuffer high_buffer ( .clk_data( clk_data ), .clk_disp( clk_disp ),
                                 .sink_valid( high_sink_valid ), .sink_data( high_sink_data ),
                                 .v_pos( v_pos ), .source_enable(), .source_data() );

column_framebuffer low_buffer ( .clk_data( clk_data ), .clk_disp( clk_disp ),
                                .sink_valid( low_sink_valid ), .sink_data( low_sink_data ),
                                .v_pos( v_pos ), .source_enable(), .source_data() );

endmodule
