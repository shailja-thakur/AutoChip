module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

	// Declare internal signals
	wire [3:0] carry;
	wire [3:0] carry_out;

	// Instantiate the full adders
	full_adder FA0(x[0], y[0], 1'b0, sum[0], carry[0]);
	full_adder FA1(x[1], y[1], carry[0], sum[1], carry[1]);
	full_adder FA2(x[2], y[2], carry[1], sum[2], carry[2]);
	full_adder FA3(x[3], y[3], carry[2], sum[3], carry_out[3]);

	// Assign the overflow bit
	assign sum[4] = carry_out[3];

	// Instantiate the full adder module
	module full_adder(
		input a,
		input b,
		input cin,
		output sum,
		output cout
	);
		assign {cout, sum} = a + b + cin;
	endmodule
