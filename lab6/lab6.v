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
assign { GPIO0_D[ 31: 15 ], GPIO0_D[ 3 ] } = 18'hz;
assign GPIO1_D[ 31: 28 ] = 4'hz;

// Clock wires
wire clk_9, clk_20, clk_50;

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

// ADC Serial Connections
wire adc_cs_n, adc_mosi, adc_miso;
assign GPIO0_D[ 14 ] = adc_cs_n; // active low
assign GPIO0_D[ 12 ] = adc_mosi;
assign GPIO0_D[ 11 ] = clk_20; // sclk

assign adc_miso = GPIO0_D[ 13 ];

// Encoder Connections, unused
wire A, B;
assign A = GPIO0_D [ 5 ];
assign B = GPIO0_D [ 4 ];
assign LEDG[ 2: 1 ] = { A, B };

// Motor Connections
wire motor_en, motor_phase;
assign GPIO0_D[ 1: 0 ] = { motor_phase, ~motor_phase };
assign GPIO0_D[ 2 ] = motor_en;

// Motor config
assign motor_en = pll_lock && SW[ 0 ];

// Display Connections
wire [ 7: 0 ] disp_red, disp_green, disp_blue;
wire disp_clk, disp_en, disp_vsync, disp_hsync;
wire valid_draw, v_blank;
wire [ 9: 0 ] h_pos, v_pos;

assign GPIO1_D[ 27: 0 ] = { disp_vsync, disp_hsync, disp_en, disp_clk, disp_blue, disp_green, disp_red };
assign disp_clk = clk_9;

// Display ouput config
assign disp_en = pll_lock;

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

// Signal visualization connections
wire [ 15: 0 ] low_analysis_source_data, high_analysis_source_data;
wire low_analysis_source_valid, high_analysis_source_valid;

// =======================================================
// Structural coding
// =======================================================

// All those PLL'd clocks
pll_all all_plls ( .inclk0( CLOCK_50 ),
                   .c0( clk_50 ), .c1( clk_9 ), .c2( clk_20 ),
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

dac_serial dac ( .sclk( clk_20 ),
                 .ast_sink_data( highpass_data ), .ast_sink_valid( highpass_valid ), .ast_sink_error( highpass_error ),
                 .sdo( dac_mosi ), .cs( dac_cs_n ) );

motor_serial motor( .sclk( clk_20 ),
                    .ast_sink_data( lowpass_data ), .ast_sink_valid( lowpass_valid ), .ast_sink_error( lowpass_error ),
                    .outh( motor_phase ), .outl() );

sample_analysis high_analysis ( .clk( clk_20 ),
                                .ast_sink_data( highpass_data ), .ast_sink_valid( highpass_valid ), .ast_sink_error( highpass_error ), .end_cycle( v_blank ),
                                .source_valid( high_analysis_source_valid ), .source_data( high_analysis_source_data ) );

sample_analysis low_analysis ( .clk( clk_20 ),
                               .ast_sink_data( lowpass_data ), .ast_sink_valid( lowpass_valid ), .ast_sink_error( lowpass_error ), .end_cycle( v_blank ),
                               .source_valid( low_analysis_source_valid ), .source_data( low_analysis_source_data ) );

dual_waterfall waterfall ( .clk_data( clk_20 ), .clk_disp( clk_9 ),
                           .h_pos( h_pos ), .v_pos( v_pos ), .valid_draw( valid_draw ), .end_cycle( v_blank ),
                           .low_sink_valid( low_analysis_source_valid ), .low_sink_data( low_analysis_source_data ),
                           .high_sink_valid( high_analysis_source_valid ), .high_sink_data( high_analysis_source_data ),
                           .disp_red( disp_red ), .disp_green( disp_green ), .disp_blue( disp_blue ) );

video_position_sync video_sync ( .disp_clk( clk_9 ), .en( pll_lock ),
                                 .valid_draw( valid_draw ), .v_blank( v_blank ), .h_pos( h_pos ), .v_pos( v_pos ),
                                 .disp_hsync( disp_hsync ), .disp_vsync( disp_vsync ) );

// This can be dealt with later should it be used
// fft audio_fft ( .clk( clk_133 ), .reset_n( pll_lock ),
//                 .inverse(), .sink_valid(), .sink_sop(), .sink_eop(), .sink_real(), .sink_imag( 1'b0 ), .sink_error(), .sink_ready(),
//                 .source_ready(), .source_error(), .source_sop(), .source_eop(), .source_valid(), .source_exp(), .source_real(), .source_imag() );

endmodule
