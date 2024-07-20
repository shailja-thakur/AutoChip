module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

	wire and1_output;
	wire and2_output;

	and2 #(2) and1 (
		.a(a),
		.b(b),
		.z(and1_output)
	);
	and2 #(2) and2 (
		.a(c),
		.b(d),
		.z(and2_output)
	);

	or2 or_gate (
		.a(and1_output),
		.b(and2_output),
		.z(out)
	);

	not not_gate (
		.a(out),
		.z(out_n)
	);
endmodule
module and2 (
	input a,
	input b,
	output z );

	assign z = a & b;
endmodule
module or2 (
	input a,
	input b,
	output z );

	assign z = a | b;
endmodule
module not (
	input a,
	output z );

	assign z = ~a;
endmodule
