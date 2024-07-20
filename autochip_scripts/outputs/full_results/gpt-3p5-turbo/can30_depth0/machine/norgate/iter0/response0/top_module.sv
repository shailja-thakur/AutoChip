module top_module(
	input a, 
	input b,
	output out
);

	// Declare internal wire for intermediate signals
	wire or_in, or_out;

	// Connect input signals to OR gate
	assign or_in = a | b;

	// Instantiate OR gate
	or_gate u1(
		.in(or_in),
		.out(or_out)
	);

	// Connect OR gate output to inverter input
	assign out = ~or_out;

endmodule
module or_gate(
	input in,
	output out
);
	assign out = |in;
endmodule
