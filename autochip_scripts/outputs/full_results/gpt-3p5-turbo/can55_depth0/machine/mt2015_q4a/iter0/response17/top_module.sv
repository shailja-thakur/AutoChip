module top_module(
	input x,
	input y,
	output z);

	/* Specify the logic for the output z */
	assign z = (x ^ y) & x;

endmodule
