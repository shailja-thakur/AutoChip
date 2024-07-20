module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	assign sum = a ^ b ^ cin; // XOR combination for sum
	assign cout = (a & b) | (b & cin) | (cin & a); // Majoritary combination for carry out

endmodule
