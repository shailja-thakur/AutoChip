module top_module(
	input a, 
	input b,
	output out
);

	and gate (
		.a(a),
		.b(b),
		.out(out)
	);

endmodule
