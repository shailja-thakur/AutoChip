module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);
	
	// Define the states using one-hot encoding
	parameter A = 6'b000001;
	parameter B = 6'b000010;
	parameter C = 6'b000100;
	parameter D = 6'b001000;
	parameter E = 6'b010000;
	parameter F = 6'b100000;

	// Combinational logic for next-state signals Y2 and Y4

	assign Y2 = 
		(y == A && w) ||
		(y == B && !w) ||
		(y == C) ||
		(y == D && w) ||
		(y == E);

	assign Y4 = 
		(y == A && w) ||
		(y == B) ||
		(y == C && !w) ||
		(y == D) ||
		(y == E && !w) ||
		(y == F && w);
	
endmodule
