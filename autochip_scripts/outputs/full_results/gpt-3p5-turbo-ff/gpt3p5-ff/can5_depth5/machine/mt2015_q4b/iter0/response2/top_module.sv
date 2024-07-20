module top_module(
	input x,
	input y,
	output z);

	// Intermediate wire for XOR operation
	wire xor_out;

	// Perform XOR operation
	assign xor_out = x ^ y;

	// Perform logical negation
	assign z = ~xor_out;

endmodule
