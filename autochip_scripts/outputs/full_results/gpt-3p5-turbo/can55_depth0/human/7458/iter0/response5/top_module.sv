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

	// Internal wires
	wire w1, w2, w3, w4;

	// AND gates
	assign w1 = p1a & p1b & p1c;
	assign w2 = p1d & p1e & p1f;

	assign w3 = p2a & p2b;
	assign w4 = p2c & p2d;

	// OR gates
	assign p1y = w1 | w2;
	assign p2y = w3 | w4;

endmodule
