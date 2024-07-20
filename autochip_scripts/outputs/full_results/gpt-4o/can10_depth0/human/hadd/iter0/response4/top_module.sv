module top_module (
	input a,
	input b,
	output sum,
	output cout
);

	assign sum = a ^ b;  // sum is the XOR of a and b
	assign cout = a & b; // carry-out is the AND of a and b

endmodule
