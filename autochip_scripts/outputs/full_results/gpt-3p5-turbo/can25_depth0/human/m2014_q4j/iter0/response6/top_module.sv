module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

	// Full adder definition
	module full_adder (
		input a,
		input b,
		input cin,
		output sum,
		output cout
	);
		assign sum = a ^ b ^ cin;
		assign cout = (a & b) | (cin & (a ^ b));
	endmodule
