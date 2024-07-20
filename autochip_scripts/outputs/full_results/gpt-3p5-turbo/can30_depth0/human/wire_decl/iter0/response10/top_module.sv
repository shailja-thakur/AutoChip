module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

	wire intermediate1, intermediate2;

	and_gate and1 (
		.a(a),
		.b(b),
		.out(intermediate1)
	);

	and_gate and2 (
		.a(c),
		.b(d),
		.out(intermediate2)
	);

	or_gate or1 (
		.a(intermediate1),
		.b(intermediate2),
		.out(out)
	);

	not_gate not1 (
		.a(out),
		.out(out_n)
	);

endmodule
module and_gate (
	input a,
	input b,
	output out
);
	assign out = a & b;
endmodule
module or_gate (
	input a,
	input b,
	output out
);
	assign out = a | b;
endmodule
module not_gate (
	input a,
	output out
);
	assign out = ~a;
endmodule
