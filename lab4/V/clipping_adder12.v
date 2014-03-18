module clipping_adder12( clk, dataa, datab, result );
input wire clk;
input wire [ 11: 0 ] dataa, datab;

output reg [ 11: 0 ] result;

wire overflow;
wire [ 11: 0 ] inital_result;

always @( posedge clk ) begin
    if ( overflow ) begin
        result <= 12'hfff; // clipped
    end
    else begin
        result <= inital_result; // not clipped
    end
end

adder12 adder ( .dataa( dataa ), .datab( datab ), .overflow( overflow ), .result( inital_result ) );

endmodule
