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
	wire andA1, andA2, andB1, andB2;
	
	// AND gates
	assign andA1 = p1a & p1b & p1c;
	assign andA2 = p1d & p1e & p1f;
	assign andB1 = p2a & p2b;
	assign andB2 = p2c & p2d;
	
	// OR gates
	assign p1y = andA1 | andA2;
	assign p2y = andB1 | andB2;
	
endmodule
