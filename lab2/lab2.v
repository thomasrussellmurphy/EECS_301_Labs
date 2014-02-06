// EECS 301 Spring 2014 Lab 2 Top Level File
// Camille Jackman (cxj106)
// Thomas Murphy (trm70)
// Due 20140207
// This file uses net-connection names from assignment_defaults.qdf
module lab2
       (
           //////////////////// Clock Input		////////////////////
           CLOCK_50,      									//	50 MHz
           CLOCK_50_2,      										//	50 MHz
           //////////////////// Push Button		////////////////////
           BUTTON,      											//	Pushbutton[2:0]
           //////////////////// DPDT Switch		////////////////////
           SW,      												//	Toggle Switch[9:0]
           //////////////////// 7-SEG Dispaly	////////////////////
           HEX0_D,      											//	Seven Segment Digit 0
           HEX0_DP,      										//	Seven Segment Digit DP 0
           HEX1_D,      											//	Seven Segment Digit 1
           HEX1_DP,      										//	Seven Segment Digit DP 1
           HEX2_D,      											//	Seven Segment Digit 2
           HEX2_DP,      										//	Seven Segment Digit DP 2
           HEX3_D,      											//	Seven Segment Digit 3
           HEX3_DP,      										//	Seven Segment Digit DP 3
           //////////////////////// LED		////////////////////////
           LEDG,      										//	LED Green[9:0]
           //////////////////// GPIO	////////////////////////////
           GPIO0_CLKIN,      									//	GPIO Connection 0 Clock In Bus
           GPIO0_CLKOUT,      								//	GPIO Connection 0 Clock Out Bus
           GPIO0_D,      										//	GPIO Connection 0 Data Bus
           GPIO1_CLKIN,      									//	GPIO Connection 1 Clock In Bus
           GPIO1_CLKOUT,      								//	GPIO Connection 1 Clock Out Bus
           GPIO1_D							//	GPIO Connection 1 Data Bus
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
////////////////////////	GPIO	////////////////////////////////
input	[ 1: 0 ] GPIO0_CLKIN;			//	GPIO Connection 0 Clock In Bus
output	[ 1: 0 ] GPIO0_CLKOUT;			//	GPIO Connection 0 Clock Out Bus
inout	[ 31: 0 ] GPIO0_D;				//	GPIO Connection 0 Data Bus
input	[ 1: 0 ] GPIO1_CLKIN;			//	GPIO Connection 1 Clock In Bus
output	[ 1: 0 ] GPIO1_CLKOUT;			//	GPIO Connection 1 Clock Out Bus
inout	[ 31: 0 ] GPIO1_D;				//	GPIO Connection 1 Data Bus


//=======================================================
//	REG/WIRE declarations
//=======================================================
wire A, B; // encoder signal A,B (async)
wire up, down; // named signals for inputs
wire enswitch; // enable switch
wire [ 7: 0 ] gainswitch; // switches to control the gain


wire [ 1: 0 ] motorinput; // PWM for locked antiphase driving
wire en; // enable motor

// Output wires for monitoring the rotgoal
wire [ 9: 0 ] rotgoal; // 2's complement rotgoal
wire [ 9: 0 ] signalrotgoal; // unsigned conversion with more bits
wire [ 20: 0 ] disprotgoal; // To the displays



//=======================================================
//	Input/Output assignments
//=======================================================
// Turn off the unused hex decimal points
assign HEX1_DP = 1'b1;
assign HEX2_DP = 1'b1;
assign HEX3_DP = 1'b1;
//	All unused inout port turn to tri-state
assign { GPIO0_D[ 31: 3 ] } = 26'hz;
assign GPIO1_D = 32'hz;
// Hold clocks low
assign GPIO0_CLKOUT = 1'b0;
assign GPIO1_CLKOUT = 1'b0;


// Assign appropriate connections to GPIO0_D ports
assign GPIO0_D[ 1: 0 ] = motorinput;
assign GPIO0_D[ 2 ] = en;

assign A = GPIO0_D [ 5 ];
assign B = GPIO0_D [ 4 ];

// Assign button and switch inputs
assign up = ~BUTTON[ 0 ]; // up and down are arbitrary, really are CW/CCW
assign down = ~BUTTON[ 1 ];

assign enswitch = SW[ 0 ]; // Switch to enable the motor
assign gainswitch = SW[ 9: 2 ]; // Switches that control the motor's gain

// Assign various LED outputs to async switch/button signals
assign LEDG [ 1: 0 ] = ~BUTTON[ 1: 0 ]; // confirm speed direction buttons
assign LEDG [ 9: 2 ] = SW[ 9: 2 ]; // binary of current gain factor
assign HEX0_D = { 6'b111111, ~enswitch }; // line when motor enabled
assign HEX0_DP = enswitch; // dot when motor disabled

// Output of rotgoal on the remaning 7-segment displays
assign signalrotgoal = rotgoal - 10'b1000000000; // Convert to unsigned with more bits
assign HEX1_D = disprotgoal[ 6: 0 ];
assign HEX2_D = disprotgoal[ 13: 7 ];
assign HEX3_D = disprotgoal[ 20: 14 ];


//=======================================================
//	Structural coding
//=======================================================

// Here's our controller interface
motorcontrol controller ( .clk( CLOCK_50 ), .ina( A ), .inb( B ), .up( up ), .down( down ), .enin( enswitch ), .en( en ), .gain( gainswitch ), .motorsignal( motorinput ), .rotgoal( rotgoal ) );
// dumbmotorcontrol controller ( .clk( CLOCK_50 ), .ina( A ), .inb( B ), .up( up ), .down( down ), .enin( enswitch ), .en( en ), .motorsignal( motorinput ), .rotgoal( rotgoal ) );

// Display gain in hex on remaning 7-seg
seg7hexdriver hex3driver ( .value( { 2'b0, signalrotgoal[ 9: 8 ] } ), .display( disprotgoal[ 20: 14 ] ) );
seg7hexdriver hex2driver ( .value( signalrotgoal[ 7: 4 ] ), .display( disprotgoal[ 13: 7 ] ) );
seg7hexdriver hex1driver ( .value( signalrotgoal[ 3: 0 ] ), .display( disprotgoal[ 6: 0 ] ) );

endmodule
