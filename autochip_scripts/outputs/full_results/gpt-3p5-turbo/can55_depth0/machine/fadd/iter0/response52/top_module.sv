module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// Calculating the sum
	assign sum = (a + b + cin) % 2;

	// Calculating the carry-out
	assign cout = (a + b + cin) >= 2;

endmodule
