// Dumb SPI Driver for 32 bits transmitted to device
// 3 wire interface to peripheral: sclk, cs, sdo
// Data moves:
//   pdi => sdo

module spi_32i_0o( sclk, pdi, pdo, send, data_valid, cs, sdi, sdo );
input wire sclk;
input wire [ 31: 0 ] pdi;
input wire send;

output reg cs;
output wire sdo;

// Not connected
input wire sdi;
output wire pdo;

output reg data_valid; // always low


reg last_send; // for edge detection of send
reg [ 4: 0 ] sent_bit; // count of last bit sent_bit
reg [ 31: 0 ] shift_out; // register for shifting out

assign sdo = shift_out[ 31 ];
assign pdo = 1'bz;

initial begin
    last_send <= 1'b0;
    sent_bit <= 5'b0;
    cs <= 1'b1;
    shift_out <= 32'b0;
    data_valid <= 1'b0;
end

always @( posedge sclk ) begin
    last_send <= send;

    // start serial transmission on rising edge of send
    if ( ~last_send & send ) begin
        cs <= 1'b0;
        shift_out <= pdi;
        sent_bit <= 5'd31; // starting with msb
    end

    // continuing transmission
    if ( cs == 1'b0 ) begin
        shift_out <= { shift_out[ 30: 0 ], 1'b0 }; // shifting data out
        sent_bit <= sent_bit - 1'b1;
    end

    // ending transmission
    if ( sent_bit == 1'b0 ) begin
        cs <= 1'b1;
    end
end

endmodule
