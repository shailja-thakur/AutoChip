module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

	// Internal wires
	wire [2:0] carry;
	wire [3:0] sum_int;

	// Full adders
	full_adder fa0(.a(x[0]), .b(y[0]), .cin(0), .cout(carry[0]), .sum(sum_int[0]));
	full_adder fa1(.a(x[1]), .b(y[1]), .cin(carry[0]), .cout(carry[1]), .sum(sum_int[1]));
	full_adder fa2(.a(x[2]), .b(y[2]), .cin(carry[1]), .cout(carry[2]), .sum(sum_int[2]));
	full_adder fa3(.a(x[3]), .b(y[3]), .cin(carry[2]), .cout(carry[3]), .sum(sum_int[3]));

	// Overflow bit
	assign sum[4] = carry[3];

	// Output sum
	assign sum[3:0] = sum_int[3:0];
endmodule
module full_adder (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);
	assign {cout, sum} = a + b + cin;
endmodule
