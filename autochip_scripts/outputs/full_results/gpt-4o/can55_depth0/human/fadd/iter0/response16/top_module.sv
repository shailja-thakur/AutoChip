module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	assign sum = a ^ b ^ cin;
	assign cout = (a & b) | (b & cin) | (a & cin);

endmodule
