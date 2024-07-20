module top_module (
	input x3,
	input x2,
	input x1,
	output f
);

	// Updated the module based on the truth table
	assign f = (x2 & ~x1) | (~x3 & (x1 | x2));

endmodule
