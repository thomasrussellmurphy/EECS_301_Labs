module storage(
           w_Address,
           w_Data,
           w_EN,
           r_HorizAddress,
           r_VertAddress,
           r_Data,
           r_EN,
           CLK
       );

input[ 11: 0 ] w_Address;
input[ 3: 0 ] w_Data;
input w_EN;
input[ 5: 0 ] r_HorizAddress;
input[ 5: 0 ] r_VertAddress;
output reg[ 3: 0 ] r_Data;
input r_EN;
input CLK;

reg[ 3: 0 ] Ram [ 4095: 0 ];
reg[ 11: 0 ] r_Address;

always @( posedge CLK ) begin
    //if (w_EN) begin
    Ram[ w_Address ] = w_Data;
    //end
    //if (r_EN) begin
    r_Address[ 5: 0 ] = r_HorizAddress[ 5: 0 ];
    r_Address[ 11: 6 ] = r_VertAddress[ 5: 0 ];
    r_Data = Ram[ r_Address ];
    //end
end
endmodule
