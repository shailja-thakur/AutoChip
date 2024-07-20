module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// Sum calculation
	assign sum = a ^ b ^ cin;

	// Carry-out calculation
	assign cout = (a & b) | (b & cin) | (a & cin);

endmodule
