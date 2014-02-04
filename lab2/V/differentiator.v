module differentiator(clk, load, in, out);
	input wire clk;
	input wire load;
	input wire [9:0] in;
	output reg [9:0] out;
	
	initial out <= 10'b0;
	
	always @(posedge clk)
		begin
			if(load == 1'b1) out <= in;
		end
	
endmodule
