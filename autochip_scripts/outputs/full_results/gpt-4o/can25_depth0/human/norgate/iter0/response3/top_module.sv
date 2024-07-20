module top_module(
	input a, 
	input b,
	output out
);

	assign out = ~(a | b); // NOR gate: output is the negation of the OR of inputs

endmodule
