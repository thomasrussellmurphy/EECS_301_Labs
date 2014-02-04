module lab2
	(
		////////////////////	Clock Input	 	////////////////////	 
		CLOCK_50,						//	50 MHz
		CLOCK_50_2,						//	50 MHz
		////////////////////	Push Button		////////////////////
		BUTTON,							//	Pushbutton[2:0]
		////////////////////	DPDT Switch		////////////////////
		SW,								//	Toggle Switch[9:0]
		////////////////////	7-SEG Dispaly	////////////////////
		HEX0_D,							//	Seven Segment Digit 0
		HEX0_DP,						//	Seven Segment Digit DP 0
		HEX1_D,							//	Seven Segment Digit 1
		HEX1_DP,						//	Seven Segment Digit DP 1
		HEX2_D,							//	Seven Segment Digit 2
		HEX2_DP,						//	Seven Segment Digit DP 2
		HEX3_D,							//	Seven Segment Digit 3
		HEX3_DP,						//	Seven Segment Digit DP 3
		////////////////////////	LED		////////////////////////
		LEDG,							//	LED Green[9:0]
		////////////////////	GPIO	////////////////////////////
		GPIO0_CLKIN,					//	GPIO Connection 0 Clock In Bus
		GPIO0_CLKOUT,					//	GPIO Connection 0 Clock Out Bus
		GPIO0_D,						//	GPIO Connection 0 Data Bus
		GPIO1_CLKIN,					//	GPIO Connection 1 Clock In Bus
		GPIO1_CLKOUT,					//	GPIO Connection 1 Clock Out Bus
		GPIO1_D							//	GPIO Connection 1 Data Bus
	);

////////////////////////	Clock Input	 	////////////////////////
input			CLOCK_50;				//	50 MHz
input			CLOCK_50_2;				//	50 MHz
////////////////////////	Push Button		////////////////////////
input	[2:0]	BUTTON;					//	Pushbutton[2:0]
////////////////////////	DPDT Switch		////////////////////////
input	[9:0]	SW;						//	Toggle Switch[9:0]
////////////////////////	7-SEG Dispaly	////////////////////////
output	[6:0]	HEX0_D;					//	Seven Segment Digit 0
output			HEX0_DP;				//	Seven Segment Digit DP 0
output	[6:0]	HEX1_D;					//	Seven Segment Digit 1
output			HEX1_DP;				//	Seven Segment Digit DP 1
output	[6:0]	HEX2_D;					//	Seven Segment Digit 2
output			HEX2_DP;				//	Seven Segment Digit DP 2
output	[6:0]	HEX3_D;					//	Seven Segment Digit 3
output			HEX3_DP;				//	Seven Segment Digit DP 3
////////////////////////////	LED		////////////////////////////
output	[9:0]	LEDG;					//	LED Green[9:0]
////////////////////////	GPIO	////////////////////////////////
input	[1:0]	GPIO0_CLKIN;			//	GPIO Connection 0 Clock In Bus
output	[1:0]	GPIO0_CLKOUT;			//	GPIO Connection 0 Clock Out Bus
inout	[31:0]	GPIO0_D;				//	GPIO Connection 0 Data Bus
input	[1:0]	GPIO1_CLKIN;			//	GPIO Connection 1 Clock In Bus
output	[1:0]	GPIO1_CLKOUT;			//	GPIO Connection 1 Clock Out Bus
inout	[31:0]	GPIO1_D;				//	GPIO Connection 1 Data Bus


//=======================================================
//  REG/WIRE declarations
//=======================================================
wire A,B; // encoder signal A,B (async)
wire up, down; // named signals for inputs
wire enswitch; // enable switch
wire [7:0] gainswitch;


wire [1:0] motorinput;
wire en; // motor control signals


//=======================================================
//  Input/Output assignments
//=======================================================
// Turn off the unused hex digits and decimal points
assign HEX0_D = {7{~enswitch}};
assign HEX1_D = 7'b1111111;
assign HEX2_D = 7'b1111111;
assign HEX3_D = 7'b1111111;
assign HEX0_DP = enswitch;
assign HEX1_DP = 1'b1;
assign HEX2_DP = 1'b1;
assign HEX3_DP = 1'b1;
//	All unused inout port turn to tri-state
assign			{GPIO0_D[31:6], GPIO0_D[3]}			=	26'hzzzzzzzz;
assign			GPIO1_D			=	32'hzzzzzzzz;
// Assign appropriate in/out state to GPIO0_D ports
assign GPIO0_D[1:0] = motorinput;
assign GPIO0_D[2] = en;

assign A = GPIO0_D [5];
assign B = GPIO0_D [4];

assign up = ~BUTTON[0];
assign down = ~BUTTON[1];

assign enswitch = SW[0];
assign gainswitch = SW[9:2];

assign LEDG [1:0] = ~BUTTON[1:0];
assign LEDG [9:2] = SW[9:2];


//=======================================================
//  Structural coding
//=======================================================	
	
	motorcontrol controller (.clk(CLOCK_50),.ina(A),.inb(B),.up(up),.down(down),.enin(enswitch),.en(en),.gain(gainswitch),.motorsignal(motorinput));
	
endmodule
