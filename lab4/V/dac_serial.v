module dac_serial( sclk, pdi, sample, sdo, cs );
input wire [ 11: 0 ] pdi; // 12 bit sample
input wire sclk;
input wire sample;

output wire sdo;
output wire cs;

parameter COMMANDBITS = 4'b0011; // Command to write and update addressed channel
parameter ADDRESSBITS = 4'b1111; // Address both DAC channels A and B

reg last_sample;
reg [ 31: 0 ] current_command;


// Always block with logic
always @( posedge sclk ) begin
    last_sample <= sample;

    if ( ~last_sample & sample ) begin
        current_command = { 4'bx, COMMANDBITS, ADDRESSBITS, pdi, 8'bx }; // build 32 bit command
    end

end

spi_32i_0o spi( .sclk( sclk ), .pdi( current_command ), .pdo(), .send( sample ), .data_valid(), .cs( cs ), .sdi(), .sdo( sdo ) );

endmodule
