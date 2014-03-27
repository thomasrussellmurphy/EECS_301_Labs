module VerticleCounter(
VSYNC,
HSYNC,
VCharCounter,
VPixelCounter
);

//states:
parameter state_topMargin = 0;
parameter state_write = 1;

//ports
input VSYNC;
input HSYNC;
output reg[5:0] VCharCounter;
output reg[2:0] VPixelCounter;

//interval variables
reg[1:0] state;
reg[1:0] blankLineCounter;


always @(posedge HSYNC) 
begin
if (VSYNC) begin 
	case(state)
		state_topMargin : begin
			if (blankLineCounter < 2) begin
				blankLineCounter = blankLineCounter + 1;
			end else 
				state = state_write;
		end
		state_write : begin 
			VPixelCounter = VPixelCounter + 1;
			if (VPixelCounter == 0)
				VCharCounter = VCharCounter + 1;
			
		end
	endcase	
end else begin // When VSYNC pulses low, reset everything
	state <= state_topMargin;
	blankLineCounter <= 0;
	VPixelCounter <= 0;
	VCharCounter <= 0;
	end	
end
endmodule 