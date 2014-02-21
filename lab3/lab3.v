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


module lab3
       (
           //////////////////// Clock Input ////////////////////
           CLOCK_50, // 50 MHz
           CLOCK_50_2, // 50 MHz
           //////////////////// Push Button ////////////////////
           BUTTON, // Pushbutton[2:0]
           //////////////////// DPDT Switch ////////////////////
           SW, // Toggle Switch[9:0]
           //////////////////// 7-SEG Dispaly ////////////////////
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
//////////////////////// 7-SEG Dispaly ////////////////////////
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
wire enswitch, modeswitch, resetbutton;
wire enswitchs, modeswitchs, resetbuttons;
wire sclk, sdata, ssync; // 3-wire interface
wire A, B;


// All inout port turn to tri-state
assign { GPIO0_D[ 31: 9 ], GPIO0_D[ 3: 0 ] } = 32'hzzzzzzzz;
assign GPIO1_D = 32'hzzzzzzzz;

// Pull out GPIO for DAC serial communications
assign GPIO0_D[ 8 ] = ssync; // active low
assign GPIO0_D[ 6 ] = sclk;
assign GPIO0_D[ 7 ] = sdata;

// Motor encoder inputs
assign A = GPIO0_D [ 5 ];
assign B = GPIO0_D [ 4 ];

assign enswitch = SW[ 1 ];
assign modeswitch = SW[ 0 ];
assign resetbutton = ~BUTTON[ 0 ]; // active-low button

assign LEDG[ 2: 0 ] = { enswitch, modeswitch, resetbutton };

// =======================================================
// Structural coding
// =======================================================

// Presynchronize important signals
synchronizer syncen ( .clk( CLOCK_50 ), .ina( enswitch ), .outs( enswitchs ) );
synchronizer syncreset ( .clk( CLOCK_50 ), .ina( resetbutton ), .outs( resetbuttons ) );
synchronizer syncmode ( .clk( CLOCK_50 ), .ina( modeswitch ), .outs( modeswitchs ) );

// Top level module
ncotodac top ( .clk( CLOCK_50 ), .reset( resetbuttons ), .en( enswitchs ), .encA( A ), .encB( B ), .mode( modeswitchs ), .sclk( sclk ), .ssync( ssync ), .sdata( sdata ) );

endmodule
