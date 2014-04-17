module dac_serial( sclk,
                   ast_sink_data, ast_sink_valid, ast_sink_error,
                   sdo, cs );

input wire sclk;
input wire [ 11: 0 ] ast_sink_data; // 12 bit sample, 2's complement
input wire ast_sink_valid;
input wire [ 1: 0 ] ast_sink_error; // Currently ignored

output wire sdo;
output wire cs;

parameter COMMANDBITS = 4'b0011; // Command to write and update addressed channel, software LDAC
parameter ADDRESSBITS = 4'b1111; // Address both DAC channels A and B

reg last_ast_sink_valid;
reg [ 31: 0 ] current_command;

reg [ 11: 0 ] unsigned_data;

always @( * ) begin
    unsigned_data <= ast_sink_data + 12'b100000000000;
end

// Always block with logic
always @( posedge sclk ) begin
    last_ast_sink_valid <= ast_sink_valid;

    if ( ~last_ast_sink_valid & ast_sink_valid ) begin
        current_command <= { 4'bx, COMMANDBITS, ADDRESSBITS, unsigned_data, 8'bx }; // build 32 bit command
    end

end

spi_32i_0o spi( .sclk( sclk ), .pdi( current_command ), .pdo(), .send( ast_sink_valid ), .data_valid(), .cs( cs ), .sdi(), .sdo( sdo ) );

endmodule
