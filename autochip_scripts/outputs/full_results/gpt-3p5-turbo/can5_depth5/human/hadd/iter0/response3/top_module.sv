module top_module (
	input a,
	input b,
	output sum,
	output cout
);

	// logic for sum and carry-out
	assign sum = a ^ b;
	assign cout = a & b;	

endmodule
