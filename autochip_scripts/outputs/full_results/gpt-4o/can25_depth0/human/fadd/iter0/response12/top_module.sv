module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// Implement the sum bit
	assign sum = a ^ b ^ cin;
	
	// Implement the carry-out bit
	assign cout = (a & b) | (b & cin) | (a & cin);

endmodule
