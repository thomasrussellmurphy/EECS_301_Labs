// Gives a 10-bit adjustable PWM signal, expects unsigned input
module pwmsignal( clk, set, outh, outl );
input wire clk;
input wire [ 9: 0 ] set; // unsigned
output reg outh; // active high
output wire outl; // active low

reg [ 9: 0 ] count; // 10 bits gives a PWM frequency off ~48.8kHz
reg [ 9: 0 ] goal; // unsigned

assign outl = ~outh;

always @( posedge clk ) begin
    count <= count + 1'b1;
    if ( count == 1'b0 ) begin
        goal <= set;
    end  // Only update the goal at zero count to avoid glitches
    if ( count <= goal ) begin
        outh <= 1;
    end
    else begin
        outh <= 0;
    end
end
endmodule
