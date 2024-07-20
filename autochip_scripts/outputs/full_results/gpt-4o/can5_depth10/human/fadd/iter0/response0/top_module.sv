module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// Compute the sum
	assign sum = a ^ b ^ cin;

	// Compute the carry out
	assign cout = (a & b) | (b & cin) | (a & cin);

endmodule
