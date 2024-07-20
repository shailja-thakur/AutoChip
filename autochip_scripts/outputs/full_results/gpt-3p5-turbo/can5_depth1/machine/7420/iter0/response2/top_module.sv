module top_module(
	input p1a, 
	input p1b, 
	input p1c, 
	input p1d, 
	output reg p1y, 
	input p2a, 
	input p2b, 
	input p2c, 
	input p2d, 
	output reg p2y
);

// Internal wires
wire n_p1y, n_p2y;

// AND gates
assign n_p1y = ~(p1a & p1b & p1c & p1d);
assign n_p2y = ~(p2a & p2b & p2c & p2d);

// Inverted outputs
always @(p1a or p1b or p1c or p1d)
	p1y <= n_p1y;
	
always @(p2a or p2b or p2c or p2d)
	p2y <= n_p2y;

endmodule
