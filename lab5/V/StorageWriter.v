module StorageWriter(
           input[ 3: 0 ] newChar,
           input[ 5: 0 ] address,
           input CLK,
           input VSync,
           output reg[ 11: 0 ] Ram_Address,
           output reg[ 3: 0 ] Ram_Data,
           output reg Ram_Enable
       );

reg[ 5: 0 ] Ram_VCounter;
reg[ 5: 0 ] Ram_HCounter;
reg state;
`define idle 		0;
`define loading 	1;
reg VSyncPrev;

initial begin
    state <= `loading;
    Ram_Enable <= 0;
    Ram_VCounter <= 2;
    Ram_HCounter <= 2;
    Ram_Data <= 0;
end



always @( posedge CLK ) begin
    if ( VSync == 1 ) begin
        Ram_Enable <= 0;
        Ram_VCounter <= 2;
        Ram_HCounter <= 2;
        Ram_Data <= newChar;
    end
    else begin
        Ram_Enable <= 1;
        Ram_HCounter <= Ram_HCounter + 1;
        if ( Ram_HCounter > 55 ) begin
            Ram_VCounter <= Ram_VCounter + 1;
            Ram_HCounter <= 2;
            if ( Ram_VCounter > 30 ) begin
                Ram_Enable <= 0;
                Ram_VCounter <= 2;
            end
        end
        Ram_Address[ 5: 0 ] <= Ram_HCounter[ 5: 0 ];
        Ram_Address[ 11: 6 ] <= Ram_VCounter[ 5: 0 ];


    end
end
endmodule


