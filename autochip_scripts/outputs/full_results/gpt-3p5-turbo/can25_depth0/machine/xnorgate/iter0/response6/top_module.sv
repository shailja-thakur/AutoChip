module top_module(
	input a, 
	input b,
	output out
);

	// XOR gate
	assign out = ~(a ^ b);

endmodule
