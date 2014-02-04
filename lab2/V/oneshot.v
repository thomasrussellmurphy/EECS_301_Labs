// A oneshot implementation that fires a 1-clk pulse 6 times a second
module oneshot ( clk, ina, outpulse );
input wire clk;
input wire ina;
output reg outpulse;

parameter DELAY_BITS = 23; // constant gives 6 pps @50MHz clock

reg [ DELAY_BITS - 1: 0 ] count;
reg triggered;

always @( posedge clk ) begin
    if ( triggered ) begin
        if ( count == 1'b0 ) begin
            triggered <= 0;
        end  // reached end of delay count
        else begin
            count <= count + 1'b1;
            outpulse <= 0;
        end
    end
    else begin // may now trigger the outpulse [again]
        if ( ina ) begin
            outpulse <= 1;
            triggered <= 1;
            count <= 1;
        end
    end
end

endmodule
