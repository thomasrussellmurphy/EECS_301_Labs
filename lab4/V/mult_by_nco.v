module mult_by_nco ( clk, reset, en, encA, encB, mode, sample, sample_in, sample_out );
input wire clk;
input wire reset;
input wire en;
input wire encA, encB, mode;
input wire sample;
input wire [ 11: 0 ] sample_in;
output reg [ 11: 0 ] sample_out;

wire encAs, encBs; // synchronized encoder signals
wire [ 14: 0 ] phaseinc;
wire [ 8: 0 ] gain; // 2's complement gain, always positive

wire [ 11: 0 ] sine; // original sine wave, 2's complement
wire [ 20: 0 ] gainsine; // sine * gain
wire [ 8: 0 ] outputsine; // sine wave after volume adjustment, unsigned
wire [ 20: 0 ] sinesample; // sample after adjustment
wire sampleclk; // sample clock: change data on rising edge, data valid on falling edge

reg [ 11: 0 ] out;

synchronizer syncA ( .clk( clk ), .ina( encA ), .outs( encAs ) );
synchronizer syncB ( .clk( clk ), .ina( encB ), .outs( encBs ) );

settingcontrol settings ( .clk( clk ), .reset( reset ), .en( en ), .encA( encAs ), .encB( encBs ), .mode( mode ), .phaseinc( phaseinc ), .gain( gain ) );

NCO osc ( .phi_inc_i( phaseinc ), .clk( sample ), .reset_n( ~reset ), .clken( 1'b1 ), .fsin_o( sine ), .fcos_o(), .out_valid() );

mult12by9 gainmult ( .dataa( sine ), .datab( gain ), .result( gainsine ) );

assign outputsine = { gainsine[ 20 ], gainsine[ 18: 11 ] }; // extract useful bits

mult12by9 samplemult ( .dataa( sample_in ), .datab( sine ), .result( sinesample ) );


always @( posedge clk ) begin
    if ( en ) begin
        // sample_out <= { outputsine, 3'b101 };
        sample_out <= { sinesample[ 20 ], sinesample[ 18: 7 ] }; // extract useful bits
    end
    else begin
        sample_out <= sample_in; // No modification
    end
end


endmodule
