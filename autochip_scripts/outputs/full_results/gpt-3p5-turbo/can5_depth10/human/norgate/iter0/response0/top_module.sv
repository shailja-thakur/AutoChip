module top_module(
	input a, 
	input b,
	output out
);

	// Assign the output to the NOR operation of the two inputs
	assign out = ~(a | b);

endmodule
