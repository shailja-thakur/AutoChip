module top_module(
	input [1:0] A,
	input [1:0] B,
	output z);

	// Assign z to be 1 if A and B are bitwise equal, otherwise assign 0
	assign z = (A == B) ? 1'b1 : 1'b0;

endmodule
