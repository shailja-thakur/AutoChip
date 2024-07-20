module top_module(
	input x,
	input y,
	output z
);

	// Declare internal wire signals
	wire x_xor_y;
	wire x_and_x_xor_y;

	// Assign internal wire signals
	assign x_xor_y = x ^ y;
	assign x_and_x_xor_y = x & x_xor_y;

	// Output assignment
	assign z = x_and_x_xor_y;
endmodule
