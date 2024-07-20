module top_module(
	input x,
	input y,
	output z);

	// wire to store the result of (x^y)
	wire xor_result;

	// assign the result of (x^y) to xor_result
	assign xor_result = x ^ y;

	// assign the final result to output z
	assign z = xor_result & x;

endmodule
