module sample_analysis( clk, ast_sink_data, ast_sink_valid, ast_sink_error, end_cycle,
                        source_valid, source_data
                      );

input wire clk;

input wire [ 11: 0 ] ast_sink_data;
input wire ast_sink_valid;
input wire [ 1: 0 ] ast_sink_error;
input wire end_cycle;

output reg source_valid;
output reg [ 15: 0 ] source_data;


//Internal Variables
wire end_cycle_pulse;
reg [11:0] unsign_it; //Converted to unsigned 
reg [23:0] padded_sample;  //Current sample padded with zeros
reg [23:0]	peak_sample;   //The biggest sample so far
reg [11:0]  padding;
reg [23:0]  divided_peak_sample;

edge_to_pulse pulse ( .clk( clk ), .in( end_cycle ), .out( end_cycle_pulse));

//Initialize internal variables
initial
begin
padding <= 12'b000000000000;
end


always @(posedge clk)
begin

	if(ast_sink_valid)
	begin
		//Convert to unsigned
		unsign_it <= ast_sink_data + 12'b100000000000;
		padded_sample <= {unsign_it, padding};
	
	//Process samples until end_cycle is asserted
		if (end_cycle_pulse)
		begin
			//Send the biggest peak so far
			source_data <= {peak_sample[23:12]};
			source_valid <= 1;	
			
		end
//While end_cycle is not asserted		
		else
		begin
			source_valid <= 0;
			//Compare current sample with biggest sample so far
			if (padded_sample > peak_sample)
				begin
					peak_sample <= padded_sample;
				end
			//No matter what, divide the peak_sample by this constant and subtract it from current peak sample
			divided_peak_sample <= peak_sample >> 8;
			peak_sample <= peak_sample - divided_peak_sample;

		end

	end
end

endmodule
