module top_module(
	input x,
	input y,
	output z);

	reg z;

	assign z = (x ^ y) & x;

endmodule
