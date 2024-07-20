module top_module(
	input x,
	input y,
	output z);

	// intermediate wire for XOR operation
	wire xor_output;

	// XOR gate for x and y inputs
	xor_gate xor_inst(
		.x1(x),
		.x2(y),
		.z(xor_output)
	);

	// AND gate for xor_output and x
	and_gate and_inst(
		.x1(x),
		.x2(xor_output),
		.z(z)
	);

endmodule
module xor_gate(
	input x1,
	input x2,
	output z);

	assign z = x1 ^ x2;

endmodule
module and_gate(
	input x1,
	input x2,
	output z);

	assign z = x1 & x2;

endmodule
