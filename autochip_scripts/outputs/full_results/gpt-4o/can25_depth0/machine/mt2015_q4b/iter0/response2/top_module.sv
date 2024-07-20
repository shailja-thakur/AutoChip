module top_module(
	input x,
	input y,
	output z);

	// Intermediate wire to hold the result of AND operation
	wire xor_result;

	// XOR gate
	assign xor_result = x ^ y;

	// NOT gate applied to the result of XOR
	assign z = ~xor_result;

endmodule
