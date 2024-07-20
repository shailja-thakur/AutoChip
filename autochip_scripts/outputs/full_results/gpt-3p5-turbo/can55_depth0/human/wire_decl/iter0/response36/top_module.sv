module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

	wire intermediate1;
	wire intermediate2;

	and gate1(
		.a(a),
		.b(b),
		.out(intermediate1)
	);

	and gate2(
		.a(c),
		.b(d),
		.out(intermediate2)
	);

	or gate3(
		.a(intermediate1),
		.b(intermediate2),
		.out(out)
	);

	not gate4(
		.in(out),
		.out(out_n)
	);

endmodule
