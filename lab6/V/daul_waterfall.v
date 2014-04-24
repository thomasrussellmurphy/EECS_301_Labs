module dual_waterfall( clk_data, clk_disp,
                       h_pos, v_pos, valid_draw,
                       low_sink_valid, low_sink_red_data, low_sink_green_data, low_sink_blue_data,
                       high_sink_valid, high_sink_red_data, high_sink_green_data, high_sink_blue_data,
                       disp_red, disp_green, disp_blue
                     );

input wire clk_data, clk_disp;
input wire [ 9: 0 ] h_pos, v_pos;
input wire valid_draw;

input wire low_sink_valid, high_sink_valid;
input wire [ 7: 0 ] low_sink_red_data, low_sink_green_data, low_sink_blue_data,
      high_sink_red_data, high_sink_green_data, high_sink_blue_data;

output reg [ 7: 0 ] disp_red, disp_green, disp_blue;

endmodule
