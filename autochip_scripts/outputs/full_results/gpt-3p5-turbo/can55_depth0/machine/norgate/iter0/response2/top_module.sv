module top_module(
	input a, 
	input b,
	output out
);

	// Declare internal wire for the OR gate output
	wire or_output;

	// OR gate
	or_gate or1 (
		.a(a),
		.b(b),
		.out(or_output)
	);

	// Inverter gate
	not_gate not1 (
		.a(or_output),
		.out(out)
	);

endmodule
module or_gate(
	input a,
	input b,
	output out
);

	assign out = a | b;

endmodule
module not_gate(
	input a,
	output out
);

	assign out = ~a;

endmodule
