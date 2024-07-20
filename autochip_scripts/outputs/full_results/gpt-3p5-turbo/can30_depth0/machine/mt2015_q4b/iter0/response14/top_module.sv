module top_module(
	input x,
	input y,
	output z);

	// Logic gate implementation
	assign z = !(x ^ y);

endmodule
