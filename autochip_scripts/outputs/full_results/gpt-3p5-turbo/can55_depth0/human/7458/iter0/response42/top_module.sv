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

	// Intermediate wires for the AND gates
	wire p1x1, p1x2, p2x1, p2x2;

	// AND gates for p1y
	and gate_p1a (p1x1, p1a, p1b, p1c);
	and gate_p1b (p1x2, p1d, p1e, p1f);

	// OR gate for p1y
	or gate_p1y (p1y, p1x1, p1x2);

	// AND gates for p2y
	and gate_p2a (p2x1, p2a, p2b);
	and gate_p2b (p2x2, p2c, p2d);

	// OR gate for p2y
	or gate_p2y (p2y, p2x1, p2x2);

endmodule
