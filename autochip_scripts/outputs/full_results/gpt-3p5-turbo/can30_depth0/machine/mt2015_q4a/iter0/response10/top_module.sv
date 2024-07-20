module top_module(
	input x,
	input y,
	output z);

	// Assign statements to calculate the output z
	assign z = (x ^ y) & x;

endmodule
