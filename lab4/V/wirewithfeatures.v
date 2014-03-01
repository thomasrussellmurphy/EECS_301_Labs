module wirewithfeatures (clk, sclk, reset, en, mode, encA, encB, sdo_dac, sdo_adc, sdi_adc, ssync_dac, ssync_adc);
input wire clk, sclk;
input wire reset, en;
input wire mode, encA, encB;
input wire sdi_adc;

output wire sdo_dac, sdo_adc;
output wire ssync_dac, ssync_adc;


// Check lab3's modules for organization over there

wire [11:0] adc_wire, dac_wire; // The input and output wires

// PLL Module

// ADC serial module and DAC serial module

// Whatever happens between adc_wire and dac_wire

endmodule
