module top_module(
	input a, 
	input b,
	input c,
	output out
);

	// Implement the truth table for the given Karnaugh map
	assign out = (a & b) | (b & c) | (a & c) | (a & b & c);

endmodule
