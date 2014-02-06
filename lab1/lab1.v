// --------------------------------------------------------------------
//
// Major Functions: lab1
//
// --------------------------------------------------------------------
//
// Revision History :
// --------------------------------------------------------------------
//	Ver  :| Author			:| Mod. Date :| Changes Made:
//	1		Thomas Murphy			20140124		Initial Rev for submission
// --------------------------------------------------------------------


module lab1
       (
           //////////////////// Clock Input		////////////////////
           CLOCK_50, 									//	50 MHz
           CLOCK_50_2, 										//	50 MHz
           //////////////////// Push Button		////////////////////
           BUTTON, 											//	Pushbutton[2:0]
           //////////////////// DPDT Switch		////////////////////
           SW, 												//	Toggle Switch[9:0]
           //////////////////// 7-SEG Dispaly	////////////////////
           HEX0_D, 											//	Seven Segment Digit 0
           HEX0_DP, 										//	Seven Segment Digit DP 0
           HEX1_D, 											//	Seven Segment Digit 1
           HEX1_DP, 										//	Seven Segment Digit DP 1
           HEX2_D, 											//	Seven Segment Digit 2
           HEX2_DP, 										//	Seven Segment Digit DP 2
           HEX3_D, 											//	Seven Segment Digit 3
           HEX3_DP, 										//	Seven Segment Digit DP 3
           //////////////////////// LED		////////////////////////
           LEDG, 										//	LED Green[9:0]
       );

////////////////////////	Clock Input		////////////////////////
input	CLOCK_50;				//	50 MHz
input	CLOCK_50_2;				//	50 MHz
////////////////////////	Push Button		////////////////////////
input	[ 2: 0 ] BUTTON;					//	Pushbutton[2:0]
////////////////////////	DPDT Switch		////////////////////////
input	[ 9: 0 ] SW;						//	Toggle Switch[9:0]
////////////////////////	7-SEG Dispaly	////////////////////////
output	[ 6: 0 ] HEX0_D;					//	Seven Segment Digit 0
output	HEX0_DP;				//	Seven Segment Digit DP 0
output	[ 6: 0 ] HEX1_D;					//	Seven Segment Digit 1
output	HEX1_DP;				//	Seven Segment Digit DP 1
output	[ 6: 0 ] HEX2_D;					//	Seven Segment Digit 2
output	HEX2_DP;				//	Seven Segment Digit DP 2
output	[ 6: 0 ] HEX3_D;					//	Seven Segment Digit 3
output	HEX3_DP;				//	Seven Segment Digit DP 3
////////////////////////////	LED		////////////////////////////
output	[ 9: 0 ] LEDG;					//	LED Green[9:0]


//=======================================================
//	REG/WIRE declarations
//=======================================================

// Turn off the hex digits and decimal points
assign HEX0_D = 7'b1111111;
assign HEX1_D = 7'b1111111;
assign HEX2_D = 7'b1111111;
assign HEX3_D = 7'b1111111;
assign HEX0_DP = 1'b1;
assign HEX1_DP = 1'b1;
assign HEX2_DP = 1'b1;
assign HEX3_DP = 1'b1;

// Turn off unused LEDGs
assign LEDG[ 8: 2 ] = 7'b0000000;

// Clock Reduction
reg [ 27: 0 ] Cont;
wire clk_slow;

// Outputs
wire [ 9: 0 ] LEDG;

// Local wires
wire [ 2: 0 ] BUTTON_AH;


//=======================================================
//	Structural coding
//=======================================================

always@( posedge CLOCK_50 ) Cont	<= Cont + 1'b1;

assign LEDG[ 9 ] = Cont[ 22 ];
assign BUTTON_AH[ 2: 0 ] = ~BUTTON[ 2: 0 ];

conditionalstatemachine STATE ( .clk( Cont[ 25 ] ), .reset( SW[ 0 ] ), .w1( BUTTON_AH[ 1 ] ), .w2( BUTTON_AH[ 2 ] ), .z1( LEDG[ 0 ] ), .z2( LEDG[ 1 ] ) );

endmodule
