// Sets the goal speed and prevents doing bad things to the goal
module speedgoal ( clk, srst, up, down, goal );
parameter MAX = 10'b1111111110; // 2's complement 510 maximum
parameter MIN = 10'b0000000001; // 2's complement -511 minimum
parameter FAKEZERO = 10'b1000000000; // conversion to/from 2's complement

input wire clk;
input wire srst;
input wire up, down;
output wire [ 9: 0 ] goal; // 2's complement

reg [ 9: 0 ] unsignedgoal; // store our current goal count
assign goal = unsignedgoal + FAKEZERO; // Make the output 2's complement

always @( posedge clk ) begin
    if ( srst ) begin
        unsignedgoal <= FAKEZERO; // Reset to 'zero' (NOT 1'b0, for whatever reason)
    end
    else begin // Consider counting safely
        if ( up & unsignedgoal < MAX ) begin
            unsignedgoal <= unsignedgoal + 10'b1;
        end
        if ( down & unsignedgoal > MIN ) begin
            unsignedgoal <= unsignedgoal - 10'b1;
        end
    end
end

endmodule
