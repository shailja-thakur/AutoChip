module AND_gate (
	input a,
	input b,
	output q
);

	assign q = a & b;

endmodule
module top_module (
	input a,
	input b,
	output q
);

	AND_gate AND1(
		.a(a),
		.b(b),
		.q(q)
	);

endmodule
