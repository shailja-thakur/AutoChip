module top_module(
	input a, 
	input b,
	output out
);
	// Assign the output to the negation of the XOR of the inputs
	assign out = ~(a ^ b);
endmodule
