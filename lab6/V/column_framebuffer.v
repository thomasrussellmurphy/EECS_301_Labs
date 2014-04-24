module column_framebuffer ( clk_data, clk_disp,
                            sink_valid, sink_red_data, sink_green_data, sink_blue_data,
                            v_pos, h_pos,
                            source_red_data, source_green_data, source_blue_data
                          );

input wire clk_data, clk_disp;

input wire sink_valid;
input wire [ 7: 0 ] sink_red_data, sink_green_data, sink_blue_data;
input wire [ 9: 0 ] v_pos, h_pos;

output reg [ 7: 0 ] source_red_data, source_green_data, source_blue_data;

endmodule
