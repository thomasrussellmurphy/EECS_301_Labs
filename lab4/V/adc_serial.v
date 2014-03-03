module adc_serial( sclk, pdo, sample, sdo, sdi, cs );
input wire sclk;
input wire sample;
input wire sdi;

output wire cs;
output reg [ 11: 0 ] pdo;
output wire sdo;

parameter WRSEQX = 3'b10x; // write, no sequence, don't care
parameter ADDRV0 = 3'b000; // select Vin0
parameter ADDRV1 = 3'b001; // select Vin1
parameter ADDRV3 = 3'b011; // select Vin1
parameter PMSHDWXRGCD = 6'b110x01; // full power, no shadow, don't care, 0-2Vref range, straight binary

parameter SHIFTSIZE = 5'd16; // serial interface is in 16 bit words

// Complete 16-bit words to feed the ADC
parameter NEXTCHAN0 = { WRSEQX, ADDRV0, PMSHDWXRGCD, 4'bx };
parameter NEXTCHAN1 = { WRSEQX, ADDRV1, PMSHDWXRGCD, 4'bx };
parameter NEXTCHAN3 = { WRSEQX, ADDRV3, PMSHDWXRGCD, 4'bx };
parameter STARTUPWORD = 16'b0;

reg [ 1: 0 ] startup; // keep track of startup sequence
reg last_sample;

reg [ 15: 0 ] current_command;
wire [ 15: 0 ] result;
wire data_valid;

initial begin
    pdo <= 12'b0;
end

always @( posedge sclk ) begin
    last_sample <= sample;

    if ( ~last_sample & sample ) begin
        // Deal with startup sequence of two dummy conversions
        if ( startup < 2'b10 ) begin
            startup <= startup + 1'b1;
            current_command <= STARTUPWORD;
        end
        else begin
	         startup <= 2'b10;
            // Just sampling channel 0 for now
            current_command <= NEXTCHAN0;
        end
    end

    if ( data_valid & ( startup == 2'b10 ) ) begin
        pdo <= result[ 11: 0 ]; // last 12 bits of data are the conversion result
    end
end

spi_16i_16o spi( .sclk( sclk ), .pdi( current_command ), .pdo( result ), .send( sample ), .data_valid( data_valid ), .cs( cs ), .sdi( sdi ), .sdo( sdo ) );

endmodule
