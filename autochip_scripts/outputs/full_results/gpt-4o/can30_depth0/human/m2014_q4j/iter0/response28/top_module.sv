module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

	// Full adder module declaration
	module full_adder (
		input a,
		input b,
		input cin,
		output sum,
		output cout
	);
		assign {cout, sum} = a + b + cin;
	endmodule
