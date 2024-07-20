module top_module(
	input a,
	input b,
	output out
);

	// Create XNOR gate using negation and XOR
	assign out = ~(a ^ b);

endmodule
