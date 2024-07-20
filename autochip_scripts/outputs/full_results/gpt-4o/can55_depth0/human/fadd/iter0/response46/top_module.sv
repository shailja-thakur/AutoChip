module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	assign sum = a ^ b ^ cin; // Sum is XOR of three inputs
	assign cout = (a & b) | (b & cin) | (cin & a); // Carry-out is generated when any two inputs are 1

endmodule
