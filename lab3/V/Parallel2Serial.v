module Parallel2Serial( parallelDataIn, sclk, sdo, sync );
input wire [ 11: 0 ] parallelDataIn; // 12 bit sample
input wire sclk; // Serialization clock is generated by PLL and fed into module

output wire sdo; // Output data to DAC
output reg sync; // sync is active low control input tied to sync pin of DAC

// Contains all the 32 bit package to send to the DAC
reg [ 31: 0 ] content;

parameter COMMANDBITS = 4'b0011; // Command to Write to and update DAC Channel n1
parameter ADDRESSBITS = 4'b1111; // Address both DAC channels A and B
parameter SPAREBITS = 4'b1010; // Nibble to put in the don't-cares of the serial transmission

reg [ 7: 0 ] cycles; // Counter counts out 32 clock cycles to meet timing specified in datasheet

assign sdo = content[ 31 ]; // Data line connected to last bit of content shift register

// Initial Conditions
initial begin
    cycles = 1'b0;
    sync = 1'b1; // Sync is held high
end

// Always block with logic
always @( posedge sclk ) begin

    cycles = cycles + 1'b1;

    if ( cycles == 8'd80 ) begin // when to reset the counter for next transmission
        cycles = 1'b0;
    end

    if ( cycles == 1'b0 ) begin
        // When sync is low, it powers on the SCLK and DIN buffers and enables the input register.
		  // Data is transferred into the DAC on the falling edges of the next 32 clocks.
        sync = 1'b0;

        // The package is created, constants for buffering don't-cares in data stream
        content <= { SPAREBITS, COMMANDBITS, ADDRESSBITS, parallelDataIn, SPAREBITS, SPAREBITS };
    end

    else if ( 1'b1 <= cycles <= 8'd31 ) begin
        // Shifts the bits in the package over once and pads it with a zero
        content <= { content[ 30: 0 ], 1'b0 };  // example temp <= {temp[2:0],1'b0};
    end

    if ( cycles == 8'd32 ) begin
        // Pull sync high after data is transferred
        sync = 1'b1;
    end

end

endmodule
