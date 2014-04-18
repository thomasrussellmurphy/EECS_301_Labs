// --------------------------------------------------------------------
// Copyright (c) 2009 by Terasic Technologies Inc.
//
// Permission:
//
// Terasic grants permission to use and modify this code for use
// in synthesis for all Terasic Development Boards and Altera Development
// Kits made by Terasic. Other use of this code, including the selling,
// duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
// This VHDL/Verilog or C/C++ source code is intended as a design reference
// which illustrates how these types of functions can be implemented.
// It is the user's responsibility to verify their design for
// consistency and functionality through the use of formal
// verification methods. Terasic provides no warranty regarding the use
// or functionality of this code.
//
// --------------------------------------------------------------------
//
// Terasic Technologies Inc
// 356 Fu-Shin E. Rd Sec. 1. JhuBei City,
// HsinChu County, Taiwan
// 302
//
// web: http: // www.terasic.com/
// email: support@terasic.com
// --------------------------------------------------------------------


module lab6
       (
           //////////////////// Clock Input ////////////////////
           CLOCK_50, // 50 MHz
           CLOCK_50_2, // 50 MHz
           //////////////////// Push Button ////////////////////
           BUTTON, // Pushbutton[2:0]
           //////////////////// DPDT Switch ////////////////////
           SW, // Toggle Switch[9:0]
           //////////////////// 7-SEG Display ////////////////////
           HEX0_D, // Seven Segment Digit 0
           HEX0_DP, // Seven Segment Digit DP 0
           HEX1_D, // Seven Segment Digit 1
           HEX1_DP, // Seven Segment Digit DP 1
           HEX2_D, // Seven Segment Digit 2
           HEX2_DP, // Seven Segment Digit DP 2
           HEX3_D, // Seven Segment Digit 3
           HEX3_DP, // Seven Segment Digit DP 3
           //////////////////////// LED ////////////////////////
           LEDG, // LED Green[9:0]
           //////////////////// / SDRAM Interface ////////////////
           DRAM_DQ, // SDRAM Data bus 16 Bits
           DRAM_ADDR, // SDRAM Address bus 13 Bits
           DRAM_LDQM, // SDRAM Low-byte Data Mask
           DRAM_UDQM, // SDRAM High-byte Data Mask
           DRAM_WE_N, // SDRAM Write Enable
           DRAM_CAS_N, // SDRAM Column Address Strobe
           DRAM_RAS_N, // SDRAM Row Address Strobe
           DRAM_CS_N, // SDRAM Chip Select
           DRAM_BA_0, // SDRAM Bank Address 0
           DRAM_BA_1, // SDRAM Bank Address 1
           DRAM_CLK, // SDRAM Clock
           DRAM_CKE, // SDRAM Clock Enable
           //////////////////// GPIO ////////////////////////////
           GPIO0_CLKIN, // GPIO Connection 0 Clock In Bus
           GPIO0_CLKOUT, // GPIO Connection 0 Clock Out Bus
           GPIO0_D, // GPIO Connection 0 Data Bus
           GPIO1_CLKIN, // GPIO Connection 1 Clock In Bus
           GPIO1_CLKOUT, // GPIO Connection 1 Clock Out Bus
           GPIO1_D // GPIO Connection 1 Data Bus
       );

//////////////////////// Clock Input ////////////////////////
input CLOCK_50; // 50 MHz
input CLOCK_50_2; // 50 MHz
//////////////////////// Push Button ////////////////////////
input [ 2: 0 ] BUTTON; // Pushbutton[2:0]
//////////////////////// DPDT Switch ////////////////////////
input [ 9: 0 ] SW; // Toggle Switch[9:0]
//////////////////////// 7-SEG Display ////////////////////////
output [ 6: 0 ] HEX0_D; // Seven Segment Digit 0
output HEX0_DP; // Seven Segment Digit DP 0
output [ 6: 0 ] HEX1_D; // Seven Segment Digit 1
output HEX1_DP; // Seven Segment Digit DP 1
output [ 6: 0 ] HEX2_D; // Seven Segment Digit 2
output HEX2_DP; // Seven Segment Digit DP 2
output [ 6: 0 ] HEX3_D; // Seven Segment Digit 3
output HEX3_DP; // Seven Segment Digit DP 3
//////////////////////////// LED ////////////////////////////
output [ 9: 0 ] LEDG; // LED Green[9:0]
////////////////////// / SDRAM Interface ////////////////////////
inout [ 15: 0 ] DRAM_DQ; // SDRAM Data bus 16 Bits
output [ 12: 0 ] DRAM_ADDR; // SDRAM Address bus 13 Bits
output DRAM_LDQM; // SDRAM Low-byte Data Mask
output DRAM_UDQM; // SDRAM High-byte Data Mask
output DRAM_WE_N; // SDRAM Write Enable
output DRAM_CAS_N; // SDRAM Column Address Strobe
output DRAM_RAS_N; // SDRAM Row Address Strobe
output DRAM_CS_N; // SDRAM Chip Select
output DRAM_BA_0; // SDRAM Bank Address 0
output DRAM_BA_1; // SDRAM Bank Address 1
output DRAM_CLK; // SDRAM Clock
output DRAM_CKE; // SDRAM Clock Enable
//////////////////////// GPIO ////////////////////////////////
input [ 1: 0 ] GPIO0_CLKIN; // GPIO Connection 0 Clock In Bus
output [ 1: 0 ] GPIO0_CLKOUT; // GPIO Connection 0 Clock Out Bus
inout [ 31: 0 ] GPIO0_D; // GPIO Connection 0 Data Bus
input [ 1: 0 ] GPIO1_CLKIN; // GPIO Connection 1 Clock In Bus
output [ 1: 0 ] GPIO1_CLKOUT; // GPIO Connection 1 Clock Out Bus
inout [ 31: 0 ] GPIO1_D; // GPIO Connection 1 Data Bus

// =======================================================
// REG/WIRE declarations
// =======================================================
// All inout port turn to tri-state
assign DRAM_DQ = 16'hzzzz;
assign { GPIO0_D[ 31: 15 ], GPIO0_D[ 3 ] } = 18'hz;
assign GPIO1_D[ 31: 28 ] = 4'hz;

// Clock wires
wire clk_133, clk_133_s, clk_9, clk_20, clk_50;

// Status lights
wire pll_lock;
assign LEDG[ 0 ] = pll_lock;

// DAC Serial Connections
wire dac_cs_n, dac_mosi, dac_ldac_n, dac_clr_n;
assign GPIO0_D[ 10 ] = dac_clr_n;
assign GPIO0_D[ 9 ] = dac_ldac_n;
assign GPIO0_D[ 8 ] = dac_cs_n; // active low
assign GPIO0_D[ 7 ] = dac_mosi;
assign GPIO0_D[ 6 ] = clk_20; // sclk

// DAC hold values
assign dac_ldac_n = 1'b0;
assign dac_clr_n = 1'b1;

// DAC signal wires
wire [ 11: 0 ] dac_sink_data;
wire dac_sink_valid;
wire [ 1: 0 ] dac_sink_error;

// ADC Serial Connections
wire adc_cs_n, adc_mosi, adc_miso;
assign GPIO0_D[ 14 ] = adc_cs_n; // active low
assign GPIO0_D[ 12 ] = adc_mosi;
assign GPIO0_D[ 11 ] = clk_20; // sclk

assign adc_miso = GPIO0_D[ 13 ];

// Encoder Connections
wire A, B;
assign A = GPIO0_D [ 5 ];
assign B = GPIO0_D [ 4 ];

// Motor Connections
wire motor_en, motor_phase;
assign GPIO0_D[ 1: 0 ] = { motor_phase, ~motor_phase };
assign GPIO0_D[ 2 ] = motor_en;

// Display Connections
wire [ 7: 0 ] disp_red, disp_green, disp_blue;
wire disp_clk, disp_en, disp_vsync, disp_hsync;
wire [ 9: 0 ] h_pos, v_pos;

assign GPIO1_D[ 27: 0 ] = { disp_vsync, disp_hsync, disp_en, disp_clk, disp_blue, disp_green, disp_red };
assign disp_clk = clk_9;

// Display ouput config
assign disp_red = 8'hce + h_pos[ 8: 1 ] - v_pos[ 6: 0 ];
assign disp_green = ~h_pos[ 7: 0 ];
assign disp_blue = v_pos[ 7: 0 ];
assign disp_en = pll_lock;

// SDRAM Connections
assign DRAM_CLK = clk_133_s;

// ADC internal communications
wire [ 11: 0 ] adc_data;
wire adc_valid;
wire [ 1: 0 ] adc_error;
wire sample;

// Highpass output connections
wire [ 11: 0 ] highpass_data;
wire highpass_valid;
wire [ 1: 0 ] highpass_error;

// Lowpass ouptut connections
wire [ 11: 0 ] lowpass_data;
wire lowpass_valid;
wire [ 1: 0 ] lowpass_error;

// Bandpass ouptut connections
wire [ 11: 0 ] bandpass_data; // all possible data output for monitoring
wire bandpass_valid;
wire [ 1: 0 ] bandpass_error;

// =======================================================
// Structural coding
// =======================================================

// All those PLL'd clocks
pll_all all_plls ( .inclk0( CLOCK_50 ),
                   .c0( clk_133 ), .c1( clk_133_s ), .c2( clk_9 ), .c3( clk_20 ), .c4( clk_50 ),
                   .locked( pll_lock ) );

sample_divider divider ( .clk( clk_20 ), .en( pll_lock ), .sample( sample ) );

adc_serial adc ( .sclk( clk_20 ),
                 .ast_source_data( adc_data ), .ast_source_valid( adc_valid ), .ast_source_error( adc_error ),
                 .sample( sample ), .sdo( adc_mosi ), .sdi( adc_miso ), .cs( adc_cs_n ) );

lowpass lowpass_filter ( .clk( clk_20 ), .reset_n( pll_lock ),
                         .ast_sink_data( adc_data ), .ast_sink_valid( adc_valid ), .ast_sink_error( adc_error ),
                         .ast_source_data( lowpass_data ), .ast_source_valid( lowpass_valid ), .ast_source_error( lowpass_error ) );

highpass highpass_filter ( .clk( clk_20 ), .reset_n( pll_lock ),
                           .ast_sink_data( adc_data ), .ast_sink_valid( adc_valid ), .ast_sink_error( adc_error ),
                           .ast_source_data( highpass_data ), .ast_source_valid( highpass_valid ), .ast_source_error( highpass_error ) );

bandpass bandpass_filter ( .clk( clk_20 ), .reset_n( pll_lock ),
                           .ast_sink_data( adc_data ), .ast_sink_valid( adc_valid ), .ast_sink_error( adc_error ),
                           .ast_source_data( bandpass_data ), .ast_source_valid( bandpass_valid ), .ast_source_error( bandpass_error ) );


avalon_io12_4_switcher filter_switcher( .clk ( clk_20 ), .select ( SW[ 1: 0 ] ),
                                        .sink_data_0 ( adc_data ), .sink_valid_0 ( adc_valid ), .sink_error_0 ( adc_error ),
                                        .sink_data_1 ( lowpass_data ), .sink_valid_1 ( lowpass_valid ), .sink_error_1 ( lowpass_error ),
                                        .sink_data_2 ( bandpass_data ), .sink_valid_2 ( bandpass_valid ), .sink_error_2 ( bandpass_error ),
                                        .sink_data_3 ( highpass_data ), .sink_valid_3 ( highpass_valid ), .sink_error_3 ( highpass_error ),
                                        .source_data ( dac_sink_data ), .source_valid ( dac_sink_valid ), .source_error ( dac_sink_error ) );

dac_serial dac ( .sclk( clk_20 ),
                 .ast_sink_data( { dac_sink_data } ), .ast_sink_valid( dac_sink_valid ), .ast_sink_error( dac_sink_error ),
                 .sdo( dac_mosi ), .cs( dac_cs_n ) );

video_position_sync video_sync( .disp_clk( clk_9 ), .en( pll_lock ),
                                .valid_draw(), .h_pos( h_pos ), .v_pos( v_pos ),
                                .disp_hsync( disp_hsync ), .disp_vsync( disp_vsync ) );

// This can be dealt with later should it be used
// fft audio_fft ( .clk( clk_133 ), .reset_n( ~pll_lock ),
//                 .inverse(), .sink_valid(), .sink_sop(), .sink_eop(), .sink_real(), .sink_imag( 1'b0 ), .sink_error(), .sink_ready(),
//                 .source_ready(), .source_error(), .source_sop(), .source_eop(), .source_valid(), .source_exp(), .source_real(), .source_imag() );

endmodule
