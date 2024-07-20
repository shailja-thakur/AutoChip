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

// Implement the p1y output as the AND operation on p1a, p1b, p1c, and p1d
assign p1y = ~(p1a & p1b & p1c & p1d);

// Implement the p2y output as the AND operation on p2a, p2b, p2c, and p2d
assign p2y = ~(p2a & p2b & p2c & p2d);

endmodule
