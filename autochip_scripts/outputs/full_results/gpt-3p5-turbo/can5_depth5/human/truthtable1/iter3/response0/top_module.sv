module top_module (
	input x3,
	input x2,
	input x1,
	output f
);

	/* In the given truth table, f is high in the following cases:
		0 | 1 | 0
		0 | 1 | 1
		1 | 0 | 1
		1 | 1 | 1
	   So, we can use the following logic to implement the truth table:
		f = (~x3 & x2 & ~x1) | (~x3 & x2 & x1) | (x3 & ~x2 & x1) | (x3 & x2 & x1);
	   Simplifying the expression, we get:
		f = x2 & ~x3 | x1 & x2 & ~x3 | x1 & ~x3 | x1 & x2 & x3; */

	assign f = x2 & ~x3 | x1 & x2 & ~x3 | x1 & ~x2 | x1 & x2 & x3;

endmodule
