module adc_serial( sclk,
                   ast_source_data, ast_source_valid, ast_source_error,
                   sample, sdo, sdi, cs );
input wire sclk;
input wire sample;
input wire sdi;

output reg [ 11: 0 ] ast_source_data;
output reg ast_source_valid;
output reg [ 1: 0 ] ast_source_error;

output wire cs;
output wire sdo;

parameter WRSEQX = 3'b10x; // write, no sequence, don't care
parameter ADDRV0 = 3'b000; // select Vin0
parameter ADDRV1 = 3'b001; // select Vin1
parameter ADDRV3 = 3'b011; // select Vin3
parameter ADDRV4 = 3'b100; // select Vin4
parameter PMSHDWXRGCD = 6'b110x00; // full power, no shadow, don't care, 0V to 2*Vref range, 2's complement

parameter SHIFTSIZE = 5'd16; // serial interface is in 16 bit words

// Complete 16-bit words to feed the ADC
parameter NEXTCHAN0 = { WRSEQX, ADDRV0, PMSHDWXRGCD, 4'bx };
parameter NEXTCHAN1 = { WRSEQX, ADDRV1, PMSHDWXRGCD, 4'bx };
parameter NEXTCHAN3 = { WRSEQX, ADDRV3, PMSHDWXRGCD, 4'bx };
parameter NEXTCHAN4 = { WRSEQX, ADDRV4, PMSHDWXRGCD, 4'bx };
parameter STARTUPWORD = 16'b0;

// Startup states
parameter INIT = 4'h0;
parameter STARTUP0 = 4'h1;
parameter STARTUP1 = 4'h2;
parameter ACTIVE = 4'h3;

reg [ 3: 0 ] startup, next_startup; // keep track of our state
reg last_serial_data_valid;

reg [ 15: 0 ] current_command;
reg [ 15: 0 ] next_command;
reg next_ast_source_valid;
reg [ 11: 0 ] next_ast_source_data;

wire [ 15: 0 ] result;
wire serial_data_valid;

initial begin
    startup <= INIT;
    ast_source_valid <= 1'b0;
    ast_source_error <= 2'b0;
end

always @( * ) begin
    // Next-state conditions
    case ( startup )
        INIT: begin // Sequence of three empty commands, invalid conversions
            next_startup <= STARTUP0;
            next_command <= STARTUPWORD;
        end
        STARTUP0: begin
            next_startup <= STARTUP1;
            next_command <= STARTUPWORD;
        end
        STARTUP1: begin
            next_startup <= ACTIVE;
            next_command <= STARTUPWORD;
        end
        ACTIVE: begin
            next_startup <= ACTIVE;
            next_command <= NEXTCHAN1; // Sampling on channel 1 for audio
        end
        default: begin
            next_startup <= INIT;
            next_command <= STARTUPWORD;
        end
    endcase

    if ( ~last_serial_data_valid && serial_data_valid && ( startup == ACTIVE ) ) begin
        next_ast_source_valid <= 1'b1;
        next_ast_source_data <= result[ 12: 1 ]; // These are where the audio bits are, bad spi_16i_16o something
    end
    else begin
        next_ast_source_valid <= 1'b0;
        next_ast_source_data <= result[ 12: 1 ];
    end
end

always @( posedge sclk ) begin
    last_serial_data_valid <= serial_data_valid;

    startup <= next_startup;

    current_command <= next_command;
    ast_source_valid <= next_ast_source_valid;
    ast_source_data <= next_ast_source_data;

    ast_source_error <= 2'b0;
end

spi_16i_16o spi( .sclk( sclk ), .pdi( current_command ), .pdo( result ), .send( sample ), .data_valid( serial_data_valid ), .cs( cs ), .sdi( sdi ), .sdo( sdo ) );

endmodule
