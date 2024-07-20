module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Adder to compute the sum
	// Use a + b as operands
	// Result stored in s
	assign s = a + b;

	// Compute whether overflow has occurred
	// This is based on the sign of the operands and the sign of the sum
	assign overflow = ((a[7] == b[7]) && (a[7] != s[7]));

endmodule
