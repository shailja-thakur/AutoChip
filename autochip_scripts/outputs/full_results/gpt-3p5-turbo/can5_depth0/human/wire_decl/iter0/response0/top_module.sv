module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n
);

	wire and1_out;
	wire and2_out;
	wire or_out;

	and and1 (
		.a(a),
		.b(b),
		.out(and1_out)
	);

	and and2 (
		.a(c),
		.b(d),
		.out(and2_out)
	);

	or or1 (
		.a(and1_out),
		.b(and2_out),
		.out(out)
	);

	not not1 (
		.a(out),
		.out(out_n)
	);

endmodule
