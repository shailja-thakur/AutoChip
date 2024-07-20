module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);
	// Full adder module
	module full_adder (
		input a,
		input b,
		input carry_in,
		output sum,
		output carry_out
	);
		assign {carry_out, sum} = a + b + carry_in;
	endmodule
