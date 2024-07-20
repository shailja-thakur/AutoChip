module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// Internal signals
	wire sum1, c1, c2;

	// Sum of a and b
	assign sum1 = a ^ b;
	assign c1 = a & b;

	// Final sum including cin
	assign sum = sum1 ^ cin;
	assign c2 = sum1 & cin;

	// Carry out
	assign cout = c1 | c2;

endmodule
