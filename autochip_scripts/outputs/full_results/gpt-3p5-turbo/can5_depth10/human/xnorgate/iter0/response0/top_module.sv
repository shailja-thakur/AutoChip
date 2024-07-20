module top_module(
	input a, 
	input b,
	output out
);

	// Create an XNOR gate
	assign out = ~(a ^ b);

endmodule
