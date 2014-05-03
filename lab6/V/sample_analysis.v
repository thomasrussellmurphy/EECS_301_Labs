module sample_analysis( clk, ast_sink_data, ast_sink_valid, ast_sink_error, end_cycle,
                        source_valid, source_data
                      );

input wire clk;

input wire [ 11: 0 ] ast_sink_data;
input wire ast_sink_valid;
input wire [ 1: 0 ] ast_sink_error;
input wire end_cycle;

output reg source_valid;
output reg [ 15: 0 ] source_data;

// Internal Variables
reg [ 23: 0 ] peak_sample;   // The biggest sample so far

wire end_cycle_pulse;
wire [ 23: 0 ] padded_sample;  // Current sample padded with zeros
wire [ 23: 0 ] divided_peak_sample;

edge_to_pulse pulse ( .clk( clk ), .in( end_cycle ), .out( end_cycle_pulse ) );

parameter PADDING = 12'h000;

// Convert to unsigned continuously for processing
assign padded_sample = { ast_sink_data + 12'b100000000000, PADDING };

// Constantly have divided version of peak sample available
assign divided_peak_sample = peak_sample >> 6;

always @( posedge clk ) begin

    // When end_cycle is asserted
    if ( end_cycle_pulse ) begin
        // Send the biggest peak so far
        source_data <= peak_sample[ 23: 8 ];
        source_valid <= 1'b1;
    end
    else begin
        source_valid <= 1'b0;
        source_data <= source_data;
    end

    // Accepting and processing input data
    if ( ast_sink_valid ) begin
        // Compare current sample with biggest sample so far
        if ( padded_sample > peak_sample ) begin
            // Gain new peak sample
            peak_sample <= padded_sample;
        end
        else begin
            // Decay the current peak value
            peak_sample <= peak_sample - divided_peak_sample;
        end
    end
    else begin
        // In all other cases, just stay the same
        peak_sample <= peak_sample;
    end
end

endmodule
