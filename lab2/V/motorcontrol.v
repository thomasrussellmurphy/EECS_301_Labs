module motorcontrol(clk, ina, inb, up, down, gain, enin, en, motorsignal);
input wire clk;
input wire ina, inb, up, down, enin;
input wire [7:0] gain;
output wire en;
output wire [1:0] motorsignal;

wire sA, sB; // synced encoder signals
wire differentiation_pulse; // pulse to activate differentiator and reset positioncounter
wire [9:0] rotcount; // 2's complement
wire [9:0] rotrate; // 2's complement
wire [9:0] rotgoal; // 2's complement
wire [9:0] pwmset; // unsigned
wire pwmout; // output signal from pwm

wire uppulse, downpulse; // count indicators for speed goal
wire enresetgoal;
wire [7:0] sgain;

assign motorsignal[1:0] = {~pwmout, pwmout};
assign enresetgoal = ~en;

synchronizer syncA (.clk(clk), .ina(ina), .outs(sA));
synchronizer syncB (.clk(clk), .ina(inb), .outs(sB));
synchronizer syncen(.clk(clk), .ina(enin), .outs(en));
synchronizer8 syncgain (.clk(clk), .ina(gain), .outs(sgain));

oneshot countup(.clk(clk), .ina(up), .outpulse(uppulse));
oneshot countdown(.clk(clk),.ina(down), .outpulse(downpulse));
speedgoal goal (.clk(clk),.srst(enresetgoal),.up(uppulse), .down(downpulse), .goal(rotgoal));

positioncounter pos (.clk(clk), .ina(sA), .inb(sB), .srst(differentiation_pulse), .out(rotcount));

timer differential_timer (.clk(clk), .overflow(differentiation_pulse));

differentiator diff (.clk(clk), .load(differentiation_pulse), .in(rotcount), .out(rotrate));

speedgoalanalysis analysis (.clk(clk),.speed(rotrate),.goal(rotgoal),.gainin(sgain),.pwmset(pwmset));

pwmsignal pwm (.clk(clk), .set(pwmset), .out(pwmout));

endmodule
