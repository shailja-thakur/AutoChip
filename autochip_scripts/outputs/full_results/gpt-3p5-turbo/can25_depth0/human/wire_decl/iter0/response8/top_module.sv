module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

	wire intermediate1; // intermediate wire 1
	wire intermediate2; // intermediate wire 2

	and gate1 (
		.a(a),
		.b(b),
		.Z(intermediate1)
	);

	and gate2 (
		.a(c),
		.b(d),
		.Z(intermediate2)
	);

	or gate3 (
		.a(intermediate1),
		.b(intermediate2),
		.Z(out)
	);

	not gate4 (
		.a(out),
		.Z(out_n)
	);

endmodule
module and (
	input a,
	input b,
	output Z );

	assign Z = a & b;

endmodule
module or (
	input a,
	input b,
	output Z );

	assign Z = a | b;

endmodule
module not (
	input a,
	output Z );

	assign Z = ~a;

endmodule
