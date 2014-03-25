module RomTable(
           cellAddress,
           horizDisp,
           vertDisp,
           clk,
           enable,
           data
       );
input [ 3: 0 ] cellAddress;
input [ 2: 0 ] horizDisp, vertDisp;
input clk;
input enable;
output reg data;

reg[ 63: 0 ] rom [ 15: 0 ];
reg[ 5: 0 ] bitIndex;
reg[ 63: 0 ] charCell;

initial begin
    $readmemb( "ROM_INIT.txt", rom );
end

always @( posedge clk ) begin
    if ( enable ) begin
        bitIndex[ 2: 0 ] <= horizDisp;
        bitIndex[ 5: 3 ] <= vertDisp;
        charCell = rom[ cellAddress ];
        data = charCell[ bitIndex ];
    end
end
endmodule

