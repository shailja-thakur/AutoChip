module top_module(
	input a, 
	input b,
	output out
);

	// gate-level implementation of NOR gate
	assign out = ~(a | b);

endmodule
