module wirewithfeatures ( clk, sclk, reset, en, mode, encA, encB, sdo_dac, sdo_adc, sdi_adc, cs_dac, cs_adc );
input wire clk;
input wire reset, en;
input wire mode, encA, encB;
input wire sdi_adc;

output wire sclk;
output wire sdo_dac, sdo_adc;
output wire cs_dac, cs_adc;

wire [ 11: 0 ] adc_wire, dac_wire, signed_output; // The input and output wires
wire sA, sB, s_reset, s_en, s_mode;
wire sample;

assign dac_wire = signed_output + 12'h800;

// Synchronizers for async inputs
synchronizer sync_A ( .clk( clk ), .ina( encA ), .outs( sA ) );
synchronizer sync_B ( .clk( clk ), .ina( encB ), .outs( sB ) );

// PLL Module
pll16mhz pll ( .inclk0( clk ), .c0( sclk ), .c1( sample ), .locked() );

// Generate sample clock from 16MHz clock ^^^

// ADC serial module and DAC serial module
dac_serial dac ( .sclk( sclk ), .pdi( dac_wire ), .sample( sample ), .sdo( sdo_dac ), .cs( cs_dac ) );
adc_serial adc ( .sclk( sclk ), .pdo( adc_wire ), .sample( sample ), .sdo( sdo_adc ), .sdi( sdi_adc ), .cs( cs_adc ) );

// Whatever happens between adc_wire and dac_wire
// assign dac_wire = adc_wire;

// Sounds like hell, Beethoven => Metal??
// echo_chamber echoes( .clk( sclk ), .sample_w( ~sample ), .in_sample( adc_wire ), .sample_r( ~sample ), .out_sample( signed_output ) );

// Multiplication by an NCO
mult_by_nco sinemult( .clk( sclk ), .reset( reset ), .en( en ), .encA( encA ), .encB( encB ), .mode( mode ), .sample( sample ), .sample_in( adc_wire ), .sample_out( signed_output ) );

endmodule
