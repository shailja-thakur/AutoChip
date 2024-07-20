module top_module(
	input a, 
	input b,
	output out
);

	// Implementing NOR gate using De Morgan's theorem
	assign out = ~(a | b);

endmodule
