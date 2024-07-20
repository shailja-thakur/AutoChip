module top_module (
	input x3,
	input x2,
	input x1,
	output f
);

	// Combinations for which the output f will be high
	assign f = (~x3 & x2 & ~x1) | (~x3 & x2 & x1) | (x3 & ~x2 & x1) | (x3 & x2 & x1);

endmodule
