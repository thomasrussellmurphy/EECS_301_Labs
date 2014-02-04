module conditionalstatemachine (clk, reset, w1, w2, z1, z2);
	input wire clk, reset;
	input wire w1, w2;
	output wire z1, z2;
	
	reg q1, q2;
	
	parameter sA = 2'b00;
	parameter sB = 2'b01;
	parameter sC = 2'b10;
	parameter sD = 2'b11;
	
	always @(posedge clk or posedge reset)
	begin
		if (reset) {q1, q2} <= sA;
		else
		case({q1, q2, w1, w2})
		// A-states
		4'b0000: {q1, q2} <= sA;
		4'b0001: {q1, q2} <= sC;
		4'b0010: {q1, q2} <= sB;
		4'b0011: {q1, q2} <= sD;
		// B-states
		4'b0100: {q1, q2} <= sB;
		4'b0101: {q1, q2} <= sA;
		4'b0110: {q1, q2} <= sD;
		4'b0111: {q1, q2} <= sC;
		// C-states
		4'b1000: {q1, q2} <= sC;
		4'b1001: {q1, q2} <= sD;
		4'b1010: {q1, q2} <= sA;
		4'b1011: {q1, q2} <= sB;
		// D-states
		4'b1100: {q1, q2} <= sD;
		4'b1101: {q1, q2} <= sB;
		4'b1110: {q1, q2} <= sC;
		4'b1111: {q1, q2} <= sA;
		
		default: {q1, q2} <= sA; // shouldn't be used
		endcase
	end
	
	// Output equations
	assign z1 = q1;
	assign z2 = q2;
endmodule
