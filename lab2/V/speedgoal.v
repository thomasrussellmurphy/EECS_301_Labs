module speedgoal (clk, srst, up, down, goal);
	input wire clk;
	input wire srst;
	input wire up, down;
	output wire [9:0] goal; // 2'o complement
	parameter MAX = 10'b1111111110; // 2's complement 1020 maximum
	parameter MIN = 10'b0000000001; // 2's complement 3 minimum
	parameter FAKEZERO = 10'b1000000000; // conversion to/from 2's complement
	
	reg [9:0] unsignedgoal;
	assign goal = unsignedgoal + FAKEZERO;
	
	always @(posedge clk) begin
		if(srst) unsignedgoal <= FAKEZERO;
		else begin
			if(up & unsignedgoal < MAX) unsignedgoal <= unsignedgoal + 10'b1;
			if(down & unsignedgoal > MIN) unsignedgoal <= unsignedgoal - 10'b1;
		end
	end
	
endmodule
