module top_module(
	input x,
	input y,
	output z);

	// Use an internal wire to hold the result of (x^y)
	wire xor_result;
	assign xor_result = x ^ y;

	// Use another wire to hold the final result of (xor_result & x)
	wire and_result;
	assign and_result = xor_result & x;

	// Assign the final result to the output port
	assign z = and_result;

endmodule
