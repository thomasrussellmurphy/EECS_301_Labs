module motor_serial( clk, ast_sink_data, ast_sink_valid, ast_sink_error, outh, outl );

input wire clk;
input wire [ 11: 0 ] ast_sink_data; // 12 bit sample, 2's complement
input wire ast_sink_valid;
input wire [ 1: 0 ] ast_sink_error; // we do nothing with this
output reg outh; // active high
output wire outl; // active low

// Internal variables
reg [ 9: 0 ] count; // 50MHz/1024 gives us a frequency of 48.8kHz
reg [ 9: 0 ] goal;
reg [ 11: 0 ] unsign_it; // converts sample into unsigned data

assign outl = ~outh; // Locked anti-phase output

always @( posedge clk ) begin
    count <= count + 1'b1;

    // Load data on every new sample
    if ( ast_sink_valid ) begin
        unsign_it <= ast_sink_data + 12'b100000000000;
    end

    // Only update the goal at zero count to avoid glitches
    if ( count == 1'b0 ) begin
        goal <= unsign_it[ 11: 2 ]; // truncate lsb to fit sample
    end

    // Create PWM based on position relative to the goal
    if ( count < goal ) begin
        outh <= 1;
    end
    else begin
        outh <= 0;
    end
end

endmodule


