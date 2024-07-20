module top_module(
	input x,
	input y,
	output z);

	// Declare intermediate signals
	wire x_or_y;
	wire not_x;
	wire not_y;
	
	// Connect the gates
	assign x_or_y = x ^ y;
	assign not_x = ~x;
	assign not_y = ~y;
	assign z = not_x & y | x & not_y;

endmodule
