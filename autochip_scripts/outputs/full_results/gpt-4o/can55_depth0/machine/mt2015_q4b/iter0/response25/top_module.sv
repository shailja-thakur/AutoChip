module top_module(
	input x,
	input y,
	output z);

	assign z = ~(x ^ y);  // Logical negation of XOR of inputs x and y

endmodule
