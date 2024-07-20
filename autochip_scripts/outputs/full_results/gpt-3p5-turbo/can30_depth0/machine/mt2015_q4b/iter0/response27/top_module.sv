module top_module(
	input x,
	input y,
	output z);

	// Declare internal wires
	wire x_xor_y;
	wire x_or_y;
	wire neg_x_or_y;
	
	// Perform XOR operation
	xor_gate xor1(
		.x1(x),
		.x2(y),
		.z(x_xor_y)
	);

	// Perform OR operation
	or_gate or1(
		.x1(x),
		.x2(y),
		.z(x_or_y)
	);

	// Perform negation operation
	not_gate not1(
		.x(x_or_y),
		.z(neg_x_or_y)
	);

	// Assign output
	assign z = neg_x_or_y;
	
endmodule
