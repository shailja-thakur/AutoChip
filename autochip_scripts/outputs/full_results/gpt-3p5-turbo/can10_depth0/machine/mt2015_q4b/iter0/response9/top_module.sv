module top_module(
	input x,
	input y,
	output z
);
	// Declare internal wire for intermediate operation
	wire w1;

	// Implementing the XOR operation using the built-in XOR gate
	xor(u1, x, y);

	// Implementing the logical negation using the logical NOT operator
	not(u2, u1, w1);

	// Assigning the output z to the negated value of the XOR operation
	assign z = w1;

endmodule
