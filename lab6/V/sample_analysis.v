module sample_analysis( clk, ast_sink_data, ast_sink_valid, ast_sink_error, end_cycle,
                        source_valid, source_red_data, source_green_data, source_blue_data
                      );

input wire clk;

input wire [ 11: 0 ] ast_sink_data;
input wire ast_sink_valid;
input wire [ 1: 0 ] ast_sink_error;
input wire end_cycle;

output wire source_valid;
output wire [ 7: 0 ] source_red_data, source_green_data, source_blue_data;

endmodule
