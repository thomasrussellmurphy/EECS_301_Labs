module dual_waterfall( clk_data, clk_disp,
                       h_pos, v_pos, valid_draw, end_cycle,
                       low_sink_valid, low_sink_data,
                       high_sink_valid, high_sink_data,
                       disp_red, disp_green, disp_blue
                     );

input wire clk_data, clk_disp;
input wire [ 9: 0 ] h_pos, v_pos;
input wire valid_draw, end_cycle;

input wire low_sink_valid, high_sink_valid;
input wire [ 15: 0 ] low_sink_data, high_sink_data;

output wire [ 7: 0 ] disp_red, disp_green, disp_blue;

reg [ 11: 0 ] counter;

assign disp_red = 8'hce + h_pos[ 8: 1 ] - v_pos[ 6: 0 ] + counter [ 7: 0 ];
assign disp_green = ~h_pos[ 7: 0 ] - counter [ 9: 2 ];
assign disp_blue = v_pos[ 7: 0 ] + ~counter [ 11: 4 ];

column_framebuffer high_buffer ( .clk_data( clk_data ), .clk_disp( clk_disp ),
                                 .sink_valid( high_sink_valid ), .sink_data( high_sink_data ),
                                 .v_pos( v_pos ), .source_enable(), .source_data() );

column_framebuffer low_buffer ( .clk_data( clk_data ), .clk_disp( clk_disp ),
                                .sink_valid( low_sink_valid ), .sink_data( low_sink_data ),
                                .v_pos( v_pos ), .source_enable(), .source_data() );

always @( posedge end_cycle ) begin
    counter <= counter + 1'b1;
end

endmodule
