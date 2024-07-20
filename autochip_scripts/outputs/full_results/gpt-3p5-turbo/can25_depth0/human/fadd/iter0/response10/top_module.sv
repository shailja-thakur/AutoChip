module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// Internal signals
	wire s1, s2, c1, c2;

	// Assignments for the internal signals
	assign s1 = a ^ b;
	assign s2 = s1 ^ cin;
	assign sum = s2;
	assign c1 = a & b;
	assign c2 = (a | b) & cin;
	assign cout = c1 | c2;

endmodule
