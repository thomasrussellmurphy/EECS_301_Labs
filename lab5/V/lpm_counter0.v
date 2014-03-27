
`timescale 1 ps / 1 ps
// synopsys translate_on
module lpm_counter0 (
	clock,
	sclr,
	cout,
	q);

	input	  clock;
	input	  sclr;
	output	  cout;
	output	[2:0]  q;

	wire  sub_wire0;
	wire [2:0] sub_wire1;
	wire  cout = sub_wire0;
	wire [2:0] q = sub_wire1[2:0];

	lpm_counter	LPM_COUNTER_component (
				.clock (clock),
				.sclr (sclr),
				.cout (sub_wire0),
				.q (sub_wire1),
				.aclr (1'b0),
				.aload (1'b0),
				.aset (1'b0),
				.cin (1'b1),
				.clk_en (1'b1),
				.cnt_en (1'b1),
				.data ({3{1'b0}}),
				.eq (),
				.sload (1'b0),
				.sset (1'b0),
				.updown (1'b1));
	defparam
		LPM_COUNTER_component.lpm_direction = "UP",
		LPM_COUNTER_component.lpm_port_updown = "PORT_UNUSED",
		LPM_COUNTER_component.lpm_type = "LPM_COUNTER",
		LPM_COUNTER_component.lpm_width = 3;


endmodule