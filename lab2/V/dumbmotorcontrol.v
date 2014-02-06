// A simple motor controller that only sets a rotation rate goal
module dumbmotorcontrol ( clk, ina, inb, up, down, enin, en, motorsignal, rotgoal );
input wire clk;
input wire ina, inb, up, down, enin;
output wire en;
output wire [ 1: 0 ] motorsignal;
output wire [ 9: 0 ] rotgoal; // 2's complement

wire sA, sB; // synced encoder signals
wire [ 9: 0 ] pwmset; // unsigned
wire pwmout;

wire uppulse, downpulse; // count indicators for speed goal
wire enresetgoal;

assign enresetgoal = ~en;
assign motorsignal = { pwmout, ~pwmout };

synchronizer syncA ( .clk( clk ), .ina( ina ), .outs( sA ) );
synchronizer syncB ( .clk( clk ), .ina( inb ), .outs( sB ) );
synchronizer syncen( .clk( clk ), .ina( enin ), .outs( en ) );

oneshot countup( .clk( clk ), .ina( up ), .outpulse( uppulse ) );
oneshot countdown( .clk( clk ), .ina( down ), .outpulse( downpulse ) );
speedgoal goal ( .clk( clk ), .srst( enresetgoal ), .up( uppulse ), .down( downpulse ), .goal( rotgoal ) );

assign pwmset = rotgoal + 10'b1000000000;

pwmsignal pwm ( .clk( clk ), .set( pwmset ), .out( pwmout ) );

endmodule
