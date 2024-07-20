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

	// Declare intermediate wires
	wire p1y_w1, p1y_w2, p2y_w1, p2y_w2;

	// Implement the logic for p1y
	assign p1y_w1 = p1a & p1b & p1c;
	assign p1y_w2 = p1d & p1e & p1f;
	assign p1y = p1y_w1 | p1y_w2;

	// Implement the logic for p2y
	assign p2y_w1 = p2a & p2b;
	assign p2y_w2 = p2c & p2d;
	assign p2y = p2y_w1 | p2y_w2;

endmodule
