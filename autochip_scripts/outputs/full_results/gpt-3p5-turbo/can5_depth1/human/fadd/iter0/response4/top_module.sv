module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

// Instantiate the full adder module
full_adder FA1(
	.a(a),
	.b(b),
	.cin(cin),
	.cout(cout),
	.sum(sum)
);

endmodule
module full_adder (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	assign sum = (a ^ b) ^ cin; // calculate the sum using XOR gates
	assign cout = (a & b) | (cin & (a ^ b)); // calculate the carry-out using AND and OR gates

endmodule
