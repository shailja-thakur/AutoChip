module top_module(
	input a,
	input b,
	output out
);
	// implementation of the NOR gate
	assign out = ~(a | b);
endmodule
