module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

	wire intermediate1;
	wire intermediate2;

	and_gate and1 (
		.in1(a),
		.in2(b),
		.out(intermediate1)
	);

	and_gate and2 (
		.in1(c),
		.in2(d),
		.out(intermediate2)
	);

	or_gate or1 (
		.in1(intermediate1),
		.in2(intermediate2),
		.out(out)
	);

	not_gate not1 (
		.in(out),
		.out(out_n)
	);

endmodule
