module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// Calculate sum
	assign sum = a ^ b ^ cin;
	
	// Calculate carry out
	assign cout = (a & b) | (b & cin) | (cin & a);

endmodule
