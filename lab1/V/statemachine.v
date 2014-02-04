module statemachine (clk, reset, w1, w2, z1, z2);
input clk;
wire clk;
input reset;
wire reset;
input w1;
wire w1;
input w2;
wire w2;
output z1;
wire z1;
output z2;
wire z2;

// state variables
wire q1;
wire q2;

// next state signals
wire d1;
wire d2;

DFF U1 (.d(d1), .clk(clk), .clrn(reset), .prn(1'b1), .q(q1));
DFF U2 (.d(d2), .clk(clk), .clrn(reset), .prn(1'b1), .q(q2));

// Excitation equations
assign d1 = ~q1 & ~q2 & w1 | ~q1 & q2 & ~w2 | q1 & q2 & ~w1 | q1 & ~q2 & w2;
assign d2 = ~q1 & ~q2 & w2 | ~q1 & q2 & w1 | q1 & q2 & ~w2 | q1 & ~q2 & ~w1;

// Output equations
assign z1 = q1;
assign z2 = q2;

endmodule
