module positioncounter (clk, ina, inb, srst, out);
input wire clk;
input wire ina, inb, srst;
output reg [9:0] out; // 2's complement

reg lasta;

always@(posedge clk) begin
    lasta <= ina;
    if(srst)
        out <= 0;
    else begin
        out <= out + 1'b1;
        if(ina & ~lasta) begin
            if(inb)
                out <= out + 1'b1;
            else
                out <= out - 1'b1;
        end
        else
            out <= out;
    end
end

endmodule
