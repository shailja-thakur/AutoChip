module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

	wire and1_out;
	wire and2_out;

	and2 #(4) and1 (
		.a(a),
		.b(b),
		.out(and1_out)
	);

	and2 #(4) and2 (
		.a(c),
		.b(d),
		.out(and2_out)
	);

	or2 #(4) or (
		.a(and1_out),
		.b(and2_out),
		.out(out)
	);

	not1 invert (
		.a(out),
		.out(out_n)
	);
	
endmodule
