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
	wire p1y_int;
	wire p2y_int;
	
	// AND gates
	and gate1 (p1y_int, p1a, p1b, p1c);
	and gate2 (p2y_int, p2a, p2b);
	and gate3 (p2y_int, p2c, p2d);
	
	// OR gates
	or gate4 (p1y, p1y_int, p1d, p1e, p1f);
	or gate5 (p2y, p2y_int);

endmodule
