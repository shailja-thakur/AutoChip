module top_module(
	input a, 
	input b,
	output out
);
	assign out = ~(a ^ b); // logical negation of the XOR of a and b
endmodule
