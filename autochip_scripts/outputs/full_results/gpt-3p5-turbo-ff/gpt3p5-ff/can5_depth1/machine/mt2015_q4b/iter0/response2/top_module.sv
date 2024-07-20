module top_module(
	input x,
	input y,
	output z);

	// Internal wire to hold the XOR result
	wire xor_output;

	// XOR gate to calculate the XOR of inputs x and y
	assign xor_output = x ^ y;

	// NOT gate to negate the XOR result
	assign z = ~xor_output;

endmodule
