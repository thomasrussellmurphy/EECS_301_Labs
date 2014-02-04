module pwmsignal(clk, set, out);
input wire clk;
input wire [9:0] set;
output reg out;

reg [9:0] count; // 11 bits gives a PWM frequency off ~48.8kHz @ twice clock
reg [9:0] goal;

always @(posedge clk) begin
    count <= count + 1'b1;
    if(count == 1'b0)
        goal <= set; // Only update the goal at zero count
    if(count <= goal)
        out <= 1;
    else
        out <= 0;
end
endmodule
