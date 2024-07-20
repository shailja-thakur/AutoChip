module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

	// Declare intermediate wires
	wire w1, w2;

	// First layer: AND gates
	and_gate and1 (
		.a(a),
		.b(b),
		.out(w1)
	);

	and_gate and2 (
		.a(c),
		.b(d),
		.out(w2)
	);

	// Second layer: OR gate
	or_gate or1 (
		.a(w1),
		.b(w2),
		.out(out)
	);

	// Inverter for out_n
	not_gate not1 (
		.a(out),
		.out(out_n)
	);

endmodule
module and_gate (
	input a,
	input b,
	output out );

	assign out = a & b;

endmodule
module or_gate (
	input a,
	input b,
	output out );

	assign out = a | b;

endmodule
module not_gate (
	input a,
	output out );

	assign out = ~a;

endmodule
