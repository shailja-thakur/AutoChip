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

	// Intermediate wires
	wire p1g, p1h, p2e, p2f;

	// AND gates
	assign p1g = p1a & p1b & p1c;
	assign p1h = p1d & p1e & p1f;

	// OR gates
	assign p1y = p1g | p1h;

	// AND gates
	assign p2e = p2a & p2b;
	assign p2f = p2c & p2d;

	// OR gates
	assign p2y = p2e | p2f;

endmodule
