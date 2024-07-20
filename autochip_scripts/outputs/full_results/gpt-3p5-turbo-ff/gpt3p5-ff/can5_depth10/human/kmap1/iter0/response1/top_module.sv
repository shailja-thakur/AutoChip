module top_module(
	input a, 
	input b,
	input c,
	output out
);

	// Implementing the logic function from the Karnaugh map
	assign out = ((a & b) | (b & c) | (a & c));

endmodule
