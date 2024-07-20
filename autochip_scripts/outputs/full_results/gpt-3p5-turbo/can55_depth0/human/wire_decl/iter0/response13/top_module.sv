module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

	wire intermediate_wire1;
	wire intermediate_wire2;

	and_gate u1 (
		.a(a),
		.b(b),
		.out(intermediate_wire1)
	);

	and_gate u2 (
		.a(c),
		.b(d),
		.out(intermediate_wire2)
	);

	or_gate u3 (
		.a(intermediate_wire1),
		.b(intermediate_wire2),
		.out(out)
	);

	not_gate u4 (
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
