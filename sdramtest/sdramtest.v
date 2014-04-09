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


module sdramtest
       (
           //////////////////// Clock Input ////////////////////
           CLOCK_50,    // 50 MHz
           CLOCK_50_2,    // 50 MHz
           //////////////////// Push Button ////////////////////
           BUTTON,    // Pushbutton[2:0]
           //////////////////// DPDT Switch ////////////////////
           SW,    // Toggle Switch[9:0]
           //////////////////// 7-SEG Display ////////////////////
           HEX0_D,    // Seven Segment Digit 0
           HEX0_DP,    // Seven Segment Digit DP 0
           HEX1_D,    // Seven Segment Digit 1
           HEX1_DP,    // Seven Segment Digit DP 1
           HEX2_D,    // Seven Segment Digit 2
           HEX2_DP,    // Seven Segment Digit DP 2
           HEX3_D,    // Seven Segment Digit 3
           HEX3_DP,    // Seven Segment Digit DP 3
           //////////////////////// LED ////////////////////////
           LEDG,    // LED Green[9:0]
           //////////////////// / SDRAM Interface ////////////////
           DRAM_DQ,    // SDRAM Data bus 16 Bits
           DRAM_ADDR,    // SDRAM Address bus 13 Bits
           DRAM_LDQM,    // SDRAM Low-byte Data Mask
           DRAM_UDQM,    // SDRAM High-byte Data Mask
           DRAM_WE_N,    // SDRAM Write Enable
           DRAM_CAS_N,    // SDRAM Column Address Strobe
           DRAM_RAS_N,    // SDRAM Row Address Strobe
           DRAM_CS_N,    // SDRAM Chip Select
           DRAM_BA_0,    // SDRAM Bank Address 0
           DRAM_BA_1,    // SDRAM Bank Address 1
           DRAM_CLK,    // SDRAM Clock
           DRAM_CKE,    // SDRAM Clock Enable
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


// =======================================================
// REG/WIRE declarations
// =======================================================
// All inout port turn to tri-state
assign GPIO0_D = 32'hzzzzzzzz;
assign GPIO1_D = 32'hzzzzzzzz;

wire CLOCK_133; // 133.333 MHZ
wire CLOCK_133_NEG; // 133.333 MHZ -3ns
wire [ 1: 0 ] dram_bank;
wire pll_locked;

wire [ 21: 0 ] addr_i;
wire [ 31: 0 ] dat_i;
wire [ 31: 0 ] dat_o;
wire we_i;
wire ack_o;
wire stb_i;
wire cyc_i;
wire rst_i;

reg [ 31: 0 ] counter;

assign LEDG[ 0 ] = pll_locked;
assign { DRAM_BA_1, DRAM_BA_0 } = dram_bank;
assign rst_i = 1'b0;

// LEDs are 0: pll lock; 1: test failure; 2: test success

// =======================================================
// Structural coding
// =======================================================

pll_sdram pll ( .areset( 1'b0 ), .inclk0( CLOCK_50 ), .c0( CLOCK_133 ), .c1( CLOCK_133_NEG ), .locked( pll_locked ) );

sdram_controller sdram_controller_inst
                 (
                     .clk_i( CLOCK_133 ),
                     .dram_clk_i( CLOCK_133_NEG ),
                     .rst_i( rst_i ),
                     .dll_locked( pll_locked ),
                     // all sdram signals
                     .dram_addr( DRAM_ADDR ),
                     .dram_bank( dram_bank ),
                     .dram_cas_n( DRAM_CAS_N ),
                     .dram_cke( DRAM_CKE ),
                     .dram_clk( DRAM_CLK ),
                     .dram_cs_n( DRAM_CS_N ),
                     .dram_dq( DRAM_DQ ),
                     .dram_ldqm( DRAM_LDQM ),
                     .dram_udqm( DRAM_UDQM ),
                     .dram_ras_n( DRAM_RAS_N ),
                     .dram_we_n( DRAM_WE_N ),
                     // wishbone bus
                     .addr_i( addr_i ),
                     .dat_i( dat_i ),
                     .dat_o( dat_o ),
                     .we_i( we_i ),
                     .ack_o( ack_o ),
                     .stb_i( stb_i ),
                     .cyc_i( cyc_i )
                 );


sdram_rw rw_inst
         (
             .clk_i( CLOCK_50 ),
             .rst_i( rst_i ),
             .addr_i( addr_i ),
             .dat_i( dat_i ),
             .dat_o( dat_o ),
             .we_i( we_i ),
             .ack_o( ack_o ),
             .stb_i( stb_i ),
             .cyc_i( cyc_i ),
             .red_led( LEDG[ 1 ] ),
             .green_led( LEDG[ 2 ] )
         );

endmodule
