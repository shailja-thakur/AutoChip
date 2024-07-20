module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);
	// Assign internal wires
	wire w1, w2, w3;

	// Assign the sum
	assign sum = a ^ b ^ cin;

	// Assign the carry-out
	assign cout = (a & b) | (a & cin) | (b & cin);

endmodule
