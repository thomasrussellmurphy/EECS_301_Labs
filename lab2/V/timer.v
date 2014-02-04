// Timer for
module timer ( clk, overflow );
input wire clk;
output reg overflow;

// count to create ~30Hz pulse @50MHz clock.
// Should prevent overflow of positioncounter
parameter MAX_COUNT = 22'd1666667;

reg [ 21: 0 ] count;

initial begin
    count <= 0;
    overflow <= 0;
end

// Ramp up to limit, send pulse during falling cycle
always @( posedge clk ) begin
    if ( count >= MAX_COUNT ) begin
        count <= 1'b0;
    end
    else begin
        count <= count + 1'b1;
    end
    if ( count == 0 ) begin
        overflow <= 1'b1;
    end
    else begin
        overflow <= 1'b0;
    end
end

endmodule
