module top_module(
	input x,
	input y,
	output z);

	// Internal wires
	wire w1;

	// Assignments
	assign w1 = x ^ y;
	assign z = w1 & x;

endmodule
