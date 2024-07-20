module top_module(
	input a, 
	input b,
	output out
);

	// Implementation of NOR gate
	assign out = ~(a | b);

endmodule
