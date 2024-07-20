module top_module(
	input x,
	input y,
	output z);
  
	// Intermediate signals
	wire xor_output, and_output;

	// XOR gate
	xor_gate xor1(
		.input1(x),
		.input2(y),
		.output(xor_output)
	);

	// AND gate
	and_gate and1(
		.input1(xor_output),
		.input2(x),
		.output(and_output)
	);

	// Assign output
	assign z = and_output;

	// XOR gate definition
	module xor_gate(
		input input1,
		input input2,
		output output
	);
		xor xor_inst(
			.a(input1),
			.b(input2),
			.c(output)
		);
	endmodule
module and_gate(
		input input1,
		input input2,
		output output
	);
		and and_inst(
			.a(input1),
			.b(input2),
			.c(output)
		);
	endmodule
