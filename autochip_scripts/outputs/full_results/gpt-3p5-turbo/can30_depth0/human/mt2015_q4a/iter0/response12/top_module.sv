module top_module(
	input x,
	input y,
	output z
);

	// Declare internal wire to hold the value of x xor y
	wire x_xor_y;

	// Assign the value of x xor y to the internal wire
	assign x_xor_y = x ^ y;

	// Assign the value of z to the result of (x_xor_y) & x
	assign z = x_xor_y & x;
	
endmodule
