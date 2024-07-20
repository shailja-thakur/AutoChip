module top_module(
	input p1a, 
	input p1b, 
	input p1c, 
	input p1d, 
	output p1y, 
	input p2a, 
	input p2b, 
	input p2c, 
	input p2d, 
	output p2y
);

	// Intermediate signals for AND gates
	wire and1, and2;

	// AND gates for both sets of inputs
	assign and1 = p1a & p1b & p1c & p1d;
	assign and2 = p2a & p2b & p2c & p2d;

	// Invert the AND gate outputs
	assign p1y = ~and1;
	assign p2y = ~and2;

endmodule
