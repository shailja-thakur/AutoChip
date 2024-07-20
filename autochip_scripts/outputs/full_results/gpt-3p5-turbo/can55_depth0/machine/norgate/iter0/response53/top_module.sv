module top_module(
	input a,
	input b,
	output out
);

	// Declare internal wire for the OR gate output
	wire or_out;

	// Declare internal wire for the inverted output
	wire inverted_out;

	// OR gate with inputs a and b, and output or_out
	or_gate or1(
		.a(a),
		.b(b),
		.out(or_out)
	);

	// Inverter gate with input or_out, and output inverted_out
	inverter inv1(
		.in(or_out),
		.out(inverted_out)
	);

	// Assign the inverted_out to the output signal
	assign out = inverted_out;

endmodule
module or_gate(
	input a,
	input b,
	output out
);
	assign out = a | b;
endmodule
module inverter(
	input in,
	output out
);
	assign out = ~in;
endmodule
