module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// Intermediate signals
	wire sum1, c1, c2;

	// First half adder
	assign sum1 = a ^ b;
	assign c1 = a & b;

	// Second half adder
	assign sum = sum1 ^ cin;
	assign c2 = sum1 & cin;

	// Carry out
	assign cout = c1 | c2;

endmodule
