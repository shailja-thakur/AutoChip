module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

// Use assign statements to calculate the sum and carry-out
assign sum = a ^ b ^ cin;
assign cout = (a & b) | (a & cin) | (b & cin);

endmodule
