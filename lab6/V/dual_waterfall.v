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

output reg [ 7: 0 ] disp_red, disp_green, disp_blue;

reg [ 11: 0 ] counter;

// Configurable background color
parameter BACKGROUND_RED = 8'h00;
parameter BACKGROUND_GREEN = 8'h0c;
parameter BACKGROUND_BLUE = 8'h00;
parameter BACKGROUND = { BACKGROUND_RED, BACKGROUND_GREEN, BACKGROUND_BLUE };

// Positions of the ends of each column
parameter COLUMN_ONE = 10'd96;
parameter COLUMN_TWO = 10'd192;
parameter COLUMN_THREE = 10'd288;
parameter COLUMN_FOUR = 10'd384;

wire [ 15: 0 ] high_data, low_data;

// Store incoming processed data
column_framebuffer high_buffer ( .clk_data( clk_data ), .clk_disp( clk_disp ),
                                 .sink_valid( high_sink_valid ), .sink_data( high_sink_data ),
                                 .v_pos( v_pos ), .source_enable( 1'b1 ), .source_data( high_data ) );

column_framebuffer low_buffer ( .clk_data( clk_data ), .clk_disp( clk_disp ),
                                .sink_valid( low_sink_valid ), .sink_data( low_sink_data ),
                                .v_pos( v_pos ), .source_enable( 1'b1 ), .source_data( low_data ) );

always @( posedge end_cycle ) begin
    counter <= counter + 1'b1;
end

always @( posedge clk_disp ) begin
    if ( valid_draw ) begin
        // Mux between the five columns with compact data assignments
        if ( h_pos < COLUMN_ONE ) begin
            { disp_red, disp_green, disp_blue } <= BACKGROUND;
        end
        else if ( h_pos < COLUMN_TWO ) begin
            { disp_red, disp_green, disp_blue } <= { low_data[ 15: 8 ], 8'h00, low_data[ 7: 0 ] };
        end
        else if ( h_pos < COLUMN_THREE ) begin
            { disp_red, disp_green, disp_blue } <= BACKGROUND;
        end
        else if ( h_pos < COLUMN_FOUR ) begin
            { disp_red, disp_green, disp_blue } <= { high_data[ 15: 8 ], 8'h00, high_data[ 7: 0 ] };
        end
        else begin
            { disp_red, disp_green, disp_blue } <= BACKGROUND;
        end
    end
    else begin
        // Blanking in invalid region
        { disp_red, disp_green, disp_blue } <= 24'h000000;
    end
end

endmodule
