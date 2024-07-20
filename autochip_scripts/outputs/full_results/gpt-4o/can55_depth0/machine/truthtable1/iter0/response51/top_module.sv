module top_module (
	input x3,
	input x2,
	input x1,
	output f
);

	// Intermediate signals to store the conditions
	wire condition1, condition2, condition3, condition4;

	// Determine each condition based on the specification
	assign condition1 = (~x3 & x2 & ~x1);
	assign condition2 = (~x3 & x2 & x1);
	assign condition3 = (x3 & ~x2 & x1);
	assign condition4 = (x3 & x2 & x1);

	// Calculate the final output using logical OR of the conditions
	assign f = condition1 | condition2 | condition3 | condition4;

endmodule
