module top_module(
	input a, 
	input b,
	output out
);

	// Implementing NOR gate
	assign out = ~(a | b);

endmodule
