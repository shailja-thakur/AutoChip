module top_module(
	input p1a, 
	input p1b, 
	input p1c, 
	input p1d,
	input p1e,
	input p1f,
	input p2a, 
	input p2b, 
	input p2c, 
	input p2d, 
	output p1y, 
	output p2y
);

	// p1y = (p1a AND p1b AND p1c) OR (p1d OR p1e OR p1f)
	assign p1y = (p1a & p1b & p1c) | (p1d | p1e | p1f);
	
	// p2y = (p2a AND p2b) OR (p2c OR p2d)
	assign p2y = (p2a & p2b) | (p2c | p2d);

endmodule
