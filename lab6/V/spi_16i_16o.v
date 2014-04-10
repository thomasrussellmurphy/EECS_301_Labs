// Dumb SPI Driver for 16 bits transmitted in each direction
// 4 wire interface to peripheral: sclk, cs, sdi, sdo
// Data moves:
//   sdi => pdo
//   pdi => sdo

module spi_16i_16o( sclk, pdi, pdo, send, data_valid, cs, sdi, sdo );
input wire sclk;
input wire [ 15: 0 ] pdi;
input wire send;
input wire sdi;

output reg cs;
output wire sdo;
output reg [ 15: 0 ] pdo;
output reg data_valid;

reg last_send; // for edge detection of send
reg [ 4: 0 ] sent_bit; // count of last bit sent_bit
reg [ 15: 0 ] shift_out; // register for shifting out

assign sdo = shift_out[ 15 ];

initial begin
    last_send <= 1'b0;
    sent_bit <= 5'b0;
    cs <= 1'b1;
    shift_out <= 16'b0;
    data_valid <= 1'b0;
end

always @( posedge sclk ) begin
    last_send <= send;

    // start serial transmission on rising edge of send
    if ( ~last_send & send ) begin
        cs <= 1'b0;
        shift_out <= pdi;
        sent_bit <= 5'd15; // starting with msb
        data_valid <= 1'b0; // set data not-valid
        pdo <= 1'b0; // zero internal storage register
    end

    // continuing transmission
    if ( cs == 1'b0 ) begin
        pdo <= { pdo[ 14: 0 ], sdi }; // shifting data into storage
        shift_out <= { shift_out[ 14: 0 ], 1'b0 }; // shifting data out
        sent_bit <= sent_bit - 1'b1;
    end

    // ending transmission
    if ( sent_bit == 1'b0 ) begin
        cs <= 1'b1;
        data_valid <= 1'b1;
    end

end

endmodule
