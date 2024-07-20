module top_module(
	input p1a, 
	input p1b, 
	input p1c, 
	input p1d,
	input p1e,
	input p1f,
	output p1y, 
	input p2a, 
	input p2b, 
	input p2c, 
	input p2d, 
	output p2y
);

	// Output p1y is the result of the AND operation on p1a, p1b, and p1c
	assign p1y = p1a & p1b & p1c;

	// Output p2y is the result of the AND operation on p2a and p2b
	assign p2y = p2a & p2b;

	// Output p1y is also ORed with the last three inputs p1d, p1e, and p1f
	assign p1y = p1y | p1d | p1e | p1f;

	// Output p2y is also ORed with the last two inputs p2c and p2d
	assign p2y = p2y | p2c | p2d;

endmodule
