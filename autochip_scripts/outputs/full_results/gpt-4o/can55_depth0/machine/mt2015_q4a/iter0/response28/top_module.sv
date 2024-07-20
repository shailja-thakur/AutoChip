module top_module(
	input x,
	input y,
	output z);

	// Intermediate wire to hold the result of XOR operation
	wire xor_result;

	// XOR operation between inputs x and y
	assign xor_result = x ^ y;

	// AND operation between the result of XOR and input x
	assign z = xor_result & x;

endmodule
