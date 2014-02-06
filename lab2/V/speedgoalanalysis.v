// Do all that difficult analysis of the speed goal vs measured speed
module speedgoalanalysis ( clk, speed, goal, gainin, pwmset );
parameter GAIN = 8'b11111000; // Gain between 1 and 255
parameter NORMALIZATION = 10'b1000000000; // Add this to go from 2's complement to unsigned

input wire clk;
input wire [ 9: 0 ] speed, goal; // 2's complement
input wire [ 7: 0 ] gainin; // unsigned
output reg [ 9: 0 ] pwmset; // unsigned

wire [ 8: 0 ] posgain; // 2's complement, force to be positive

wire [ 9: 0 ] error; // 2's complement
wire [ 18: 0 ] gainerror; // 2's complement with additional bits
reg [ 9: 0 ] correction; // adjusted

assign posgain = { 1'b0, gainin[ 7: 0 ] }; // convert to 2's complement positive-only

addsub10with10 diff ( .add_sub( 1'b0 ), .dataa( goal ), .datab( speed ), .result( error ) ); // error = goal - speed;
mult10by9 mult ( .dataa( error ), .datab( posgain ), .result( gainerror ) );

always @( posedge clk ) begin
    // divide to normalize to 0<=gain<1, loose msb (non-sign) of gainerror
    // because it is extra from the conversion to 2's complement
    correction <= { gainerror[ 18 ], gainerror[ 16: 8 ] };
    pwmset <= correction + NORMALIZATION; // then go all unsigned on us
end

endmodule
