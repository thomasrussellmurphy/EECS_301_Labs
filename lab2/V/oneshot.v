module oneshot (clk, ina, outpulse);
	input wire clk;
	input wire ina;
	output reg outpulse;
	
	parameter DELAY_BITS = 23; // constant ina gives 6 pps
	
	reg [DELAY_BITS-1:0] count;
	reg triggered;
	
	always @(posedge clk) begin
		if(triggered) begin
			if(count == 1'b0) triggered <= 0; // reached end of delay count
			else begin
				count <= count + 1'b1;
				outpulse <= 0;
			end
		end else begin // can trigger the outpulse
			if(ina) begin
				outpulse <= 1;
				triggered <= 1;
				count <= 1;
			end
		end
	end
	
endmodule
