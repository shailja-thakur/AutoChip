module top_module(
	input a, 
	input b,
	output out
);
	/* Logic to calculate the logical negation of the logical OR */
	assign out = ~(a || b);
endmodule
