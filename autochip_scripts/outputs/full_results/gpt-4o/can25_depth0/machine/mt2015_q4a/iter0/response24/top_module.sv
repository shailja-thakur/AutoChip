module top_module(
	input x,
	input y,
	output z);

	// Intermediate wire to hold the result of x XOR y
	wire xor_result;

	// Perform XOR operation between x and y
	assign xor_result = x ^ y;

	// Perform AND operation between xor_result and x
	assign z = xor_result & x;

endmodule
