module top_module (
	input clk,
	input L,
	input r_in,
	input q_in,
	output reg Q);

	// Flip-flop
	DFF flip_flop (
		.D(r_in),
		.Q(Q),
		.CLK(clk),
		.CE(L));

	// Multiplexer
	MUX mux (
		.I0(q_in),
		.I1(Q),
		.S(L),
		.Y(Q));

endmodule