module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

	// Implement the logic based on the Karnaugh map
	assign out = (a && !b && c) || (b && !c && !d) || (!b && c && d) || (a && b && !d);

endmodule
