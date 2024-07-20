module top_module (
	input x3,
	input x2,
	input x1,
	output f
);

	// Intermediate wires to store the combinations
	wire condition1, condition2, condition3, condition4;

	// Combinations
	assign condition1 = (~x3 & x2 & ~x1);
	assign condition2 = (~x3 & x2 & x1);
	assign condition3 = (x3 & ~x2 & x1);
	assign condition4 = (x3 & x2 & x1);

	// Output determination
	assign f = (condition1 | condition2 | condition3 | condition4);

endmodule
