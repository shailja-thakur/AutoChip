module top_module (
	input a,
	input b,
	output sum,
	output cout
);

	// logic to calculate sum
	assign sum = a ^ b;

	// logic to calculate carry out
	assign cout = a & b;

endmodule
