module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	assign sum = a ^ b ^ cin; // Sum is XOR of all three inputs
	assign cout = (a & b) | (b & cin) | (cin & a); // Carry out is logic OR of any two inputs being high

endmodule
