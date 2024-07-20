module top_module (
	input x3,
	input x2,
	input x1,
	output f
);
	// Intermediate signals for the conditions
	wire condition1;
	wire condition2;
	wire condition3;
	wire condition4;

	// Determine each condition
	assign condition1 = ~x3 & x2 & ~x1;
	assign condition2 = ~x3 & x2 & x1;
	assign condition3 = x3 & ~x2 & x1;
	assign condition4 = x3 & x2 & x1;

	// Output is the logical OR of the conditions
	assign f = condition1 | condition2 | condition3 | condition4;

endmodule
