module top_module (
	input x3,
	input x2,
	input x1,
	output f
);

	// Output assignment based on truth table
	assign f = (x2 & ~x1) | (x3 & (x1 ^ x2));

endmodule
