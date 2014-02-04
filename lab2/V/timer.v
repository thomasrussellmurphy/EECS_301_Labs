module timer (clk, overflow);
	input wire clk;
	output reg overflow;
	
	parameter MAX_COUNT = 22'd1666667; // count to create ~30Hz pulse
	
	reg [21:0] count;
	
	initial begin
			count <= 0;
			overflow <= 0;
	end

			
	always @(posedge clk) begin
		if (count >= MAX_COUNT) count <= 1'b0;
		else
			count <= count + 1'b1;
				if(count == 0) overflow <= 1'b1;
				else overflow <= 1'b0;
	end
	
endmodule
