module top_module(
	input x,
	input y,
	output z);

	// Logic to compute the output z
	assign z = ~(x ^ y);

endmodule
