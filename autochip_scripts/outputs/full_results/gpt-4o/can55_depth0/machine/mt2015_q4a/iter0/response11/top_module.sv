module top_module(
	input x,
	input y,
	output z);

	// Intermediate signal for the XOR of x and y
	wire xor_xy;

	// XOR operation between x and y
	assign xor_xy = x ^ y;

	// AND operation between the result of XOR and x
	assign z = xor_xy & x;

endmodule
