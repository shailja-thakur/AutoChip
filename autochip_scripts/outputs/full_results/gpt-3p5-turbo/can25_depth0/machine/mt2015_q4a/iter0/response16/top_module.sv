module top_module(
	input x,
	input y,
	output z);

	// Intermediate signals
	wire xor_result;

	// XOR gate
	assign xor_result = x ^ y;

	// AND gate
	assign z = xor_result & x;

endmodule
