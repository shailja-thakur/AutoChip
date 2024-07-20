module top_module(
	input x,
	input y,
	output z);

	// Intermediate wire
	wire xor_xy;

	// XOR operation between inputs x and y
	assign xor_xy = x ^ y;

	// AND operation between xor_xy and input x
	assign z = xor_xy & x;

endmodule
