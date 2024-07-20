module top_module(
	input a, 
	input b,
	output out
);

	// XNOR gate implementation
	assign out = ~(a^b);

endmodule
