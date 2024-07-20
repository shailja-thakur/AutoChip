module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

	wire u1;
	wire u2;

	and_gate u1_and (
		.a(a),
		.b(b),
		.out(u1)
	);

	and_gate u2_and (
		.a(c),
		.b(d),
		.out(u2)
	);

	or_gate u3_or (
		.a(u1),
		.b(u2),
		.out(out)
	);

	not_gate u4_not (
		.a(out),
		.out(out_n)
	);

endmodule
