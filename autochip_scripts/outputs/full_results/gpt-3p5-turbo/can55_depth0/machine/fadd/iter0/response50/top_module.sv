module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// assign the sum output
	assign sum = (a + b + cin) % 2;

	// assign the cout output
	assign cout = (a + b + cin) >= 2;

endmodule
