// A numerical differentiator that converts the count on in[9:0] to a speed
// on out[9:0] by monitoring the load signal.
module differentiator( clk, load, in, out );
input wire clk;
input wire load;
input wire [ 9: 0 ] in;
output reg [ 9: 0 ] out;

initial
    out <= 10'b0;

always @( posedge clk ) begin
    if ( load == 1'b1 ) begin
        out <= in;
    end
end

endmodule
