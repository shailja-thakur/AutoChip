module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

	wire intermediate_1;
	wire intermediate_2;

	and_gate g1 (
		.input_a(a),
		.input_b(b),
		.output(intermediate_1)
	);

	and_gate g2 (
		.input_a(c),
		.input_b(d),
		.output(intermediate_2)
	);

	or_gate g3 (
		.input_a(intermediate_1),
		.input_b(intermediate_2),
		.output(out)
	);

	not_gate g4 (
		.input(intermediate_1),
		.output(out_n)
	);

endmodule
module and_gate (
	input input_a,
	input input_b,
	output output );

	and gate_output(
		input_a,
		input_b,
		output
	);

endmodule
module or_gate (
	input input_a,
	input input_b,
	output output );

	or gate_output(
		input_a,
		input_b,
		output
	);

endmodule
module not_gate (
	input input,
	output output );

	not gate_output(
		input,
		output
	);

endmodule
