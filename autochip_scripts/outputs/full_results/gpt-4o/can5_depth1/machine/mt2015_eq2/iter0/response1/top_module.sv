module top_module(
	input [1:0] A,
	input [1:0] B,
	output z);

	// z is 1 if A is equal to B
	assign z = (A == B) ? 1 : 0;

endmodule
