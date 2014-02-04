// Counts the position of the rotor based on out-of-phase ina, inb signals
// Can only count between -512 to 511 rotor pulses before reset
module positioncounter ( clk, ina, inb, srst, out );
input wire clk;
input wire ina, inb, srst;
output reg [ 9: 0 ] out; // 2's complement

reg lasta;

always@( posedge clk ) begin
    lasta <= ina; // record a for edge detection
    if ( srst ) begin // reset and be done
        out <= 0;
    end
    else begin
        out <= out + 1'b1; // What does this do??? The code worked...
        // TODO: make this an appropriately hinted U/D counter?
        if ( ina & ~lasta ) begin // detect edge, count up or down
            if ( inb ) begin
                out <= out + 1'b1;
            end
            else begin
                out <= out - 1'b1;
            end
        end
        else begin
            out <= out;
        end
    end
end

endmodule
