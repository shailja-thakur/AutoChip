module top_module(
	input a, 
	input b,
	input c,
	output out
);

	// Assign output based on the truth table
	assign out = (a & (b | c));

endmodule
