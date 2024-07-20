module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

	wire intermediate1;
	wire intermediate2;
	wire out_n;

	and_gate and_gate1 (
		.a(a),
		.b(b),
		.out(intermediate1)
	);
	and_gate and_gate2 (
		.a(c),
		.b(d),
		.out(intermediate2)
	);
	or_gate or_gate3 (
		.a(intermediate1),
		.b(intermediate2),
		.out(out)
	);
	not_gate not_gate4 (
		.in(out),
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
	input in,
	output out
);
	assign out = ~in;
endmodule
