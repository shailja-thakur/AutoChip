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

	// Internal wires for intermediate signals
	wire w1, w2;

	// AND gates
	assign w1 = p1a & p1b & p1c;
	assign w2 = p1d & p1e & p1f;

	// OR gates
	assign p1y = w1 | w2;

	assign p2y = p2a & p2b | p2c & p2d;

endmodule
