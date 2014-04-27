module motor_serial( sclk,ast_sink_data, ast_sink_valid, ast_sink_error, outh, outl);

input wire sclk;
input wire [ 11: 0 ] ast_sink_data; // 12 bit sample, 2's complement
input wire ast_sink_valid;
input wire [ 1: 0 ] ast_sink_error; // we do nothing with this
output reg outh; // active high
output wire outl; // active low

//Internal variables
reg [ 14: 0 ] count; // 15 bits gives about 32.768 Hz
reg [ 11: 0 ] goal; 


assign outl = ~outh;

always @( posedge sclk ) 
begin

	if (ast_sink_valid)
		begin
		count <= count + 1'b1;
		
		if ( count == 1'b0 )
			begin
			goal <= ast_sink_data;
			end  // Only update the goal at zero count to avoid glitches
			
		if ( count <= goal )
			begin
			outh <= 1;
			end
			
		if (count >= 20_000) // For 20 Mhz clk
			begin
			count = 0;
			end
    
		else 
			begin
        outh <= 0;
			end
	 end
end
endmodule
 
					