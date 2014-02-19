module ncotodac ( clk, reset, en, encA, encB, mode, ssync, sclk, sdata );
input wire clk;
input wire reset;
input wire en;
input wire encA, encB, mode;
output wire sclk, ssync, sdata;

wire encAs, encBs; // synchronized encoder signals
wire [ 13: 0 ] phaseinc;
wire [ 8: 0 ] gain; // 2's complement gain, always positive

wire [ 11: 0 ] sine; // original sine wave, 2's complement
wire [ 20: 0 ] gainsine; // sine * gain
wire [ 11: 0 ] outputsine; // sine wave after volume adjustment, unsigned
wire sampleclk; // sample clock: change data on rising edge, data valid on falling edge


synchronizer syncA ( .clk( clk ), .ina( encA ), .outs( encAs ) );
synchronizer syncB ( .clk( clk ), .ina( encB ), .outs( encBs ) );

settingcontrol settings ( .clk( clk ), .reset( reset ), .en( en ), .encA( encAs ), .encB( encBs ), .mode( mode ), .phaseinc( phaseinc ), .gain( gain ) );

NCO osc ( .phi_inc_i( phaseinc ), .clk( sampleclk ), .reset_n( ~reset ), .clken( 1'b1 ), .fsin_o( sine ), .fcos_o(), .out_valid() );

mult12by9 gainmult( .dataa( sine ), .datab( gain ), .result( gainsine ) );

assign outputsine = { gainsine[ 20 ], gainsine[ 18: 8 ] } + 12'b100000000000; // extract useful bits, normalize to unsigned

// drop in serial output module here. Input: outputsine. Output: sampleclk, sclk, ssync, sdata.

endmodule
