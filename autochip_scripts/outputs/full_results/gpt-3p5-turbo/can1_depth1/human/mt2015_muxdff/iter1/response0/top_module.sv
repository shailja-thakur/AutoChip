module top_module(
	input clk,
	input L,
	input q_in,
	input r_in,
	output reg Q
	);

	wire q_int_1, q_int_2, q_int_3;

	flipflop ff_1(
		.clk(clk),
		.D(q_in),
		.Q(q_int_1)
		);

	flipflop ff_2(
		.clk(clk),
		.D(q_int_1 ^ q_int_3),
		.Q(q_int_2)
		);

	flipflop ff_3(
		.clk(clk),
		.D(q_int_2),
		.Q(Q)
		);

	multiplexer_2to1 mux_1(
		.S(L),
		.I0(r_in),
		.I1(q_int_2),
		.O(q_int_3)
		);

endmodule
