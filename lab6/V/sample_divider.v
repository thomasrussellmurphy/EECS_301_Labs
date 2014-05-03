module sample_divider( clk, en, sample );
input clk;
input en;
output reg sample; // 20 MHz down to 50 kHz single-cycle pulses

parameter MAX_COUNT = 10'd400; // Division factor

reg [ 9: 0 ] counter;

always @( posedge clk ) begin
    // Always be incrementing the counter
    if ( counter == MAX_COUNT ) begin
        counter <= 1'b0;
    end
    else begin
        counter <= counter + 1'b1;
    end

    if ( en ) begin
        sample <= ( counter == 1'b0 ); // Create output pulse when enabled
    end
    else begin
        sample <= 1'b0;
    end
end

endmodule
