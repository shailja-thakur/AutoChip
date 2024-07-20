module top_module (
	// Inputs
	input a,
	input b,
	input c,
	input d,

	// Outputs
	output out,
	output out_n
);

	// Wires
	wire w1;
	wire w2;

	// Logic gates
	and #(

	) and1 (
		.a(a),
		.b(b),
		.z(w1)
	);
	and #(

	) and2 (
		.a(c),
		.b(d),
		.z(w2)
	);
	or #(

	) or1 (
		.a(w1),
		.b(w2),
		.z(out)
	);
	not #(

	) not1 (
		.a(out),
		.z(out_n)
	);
endmodule
