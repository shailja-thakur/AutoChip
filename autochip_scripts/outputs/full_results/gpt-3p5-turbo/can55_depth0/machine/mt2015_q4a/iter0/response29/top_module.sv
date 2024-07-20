module top_module(
	input x,
	input y,
	output z);

	// XOR gate
	wire xor_output;
	xor xor_gate(x, y, xor_output);

	// AND gate
	and and_gate(x, xor_output, z);

endmodule
