module top_module (
	input x3,
	input x2,
	input x1,
	output f
);

	// Define intermediate signals
	wire w1, w2, w3, w4;

	// Implementing the combination
	assign w1 = ~(x3 & x2 & ~x1);
	assign w2 = ~(x3 & x2 & x1);
	assign w3 = ~(~x3 & ~x2 & x1);
	assign w4 = ~(x3 & ~x2 & x1);

	// Final output
	assign f = w1 | w2 | w3 | w4;

endmodule
