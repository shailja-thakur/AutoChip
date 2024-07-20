module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

	wire [3:0] carry;
	wire [3:0] sum_bit;

	// instantiate 4 full adders
	FourBitFullAdder f1 (.x(x[0]), .y(y[0]), .cin(1'b0), .sum(sum_bit[0]), .carry(carry[0]));
	FourBitFullAdder f2 (.x(x[1]), .y(y[1]), .cin(carry[0]), .sum(sum_bit[1]), .carry(carry[1]));
	FourBitFullAdder f3 (.x(x[2]), .y(y[2]), .cin(carry[1]), .sum(sum_bit[2]), .carry(carry[2]));
	FourBitFullAdder f4 (.x(x[3]), .y(y[3]), .cin(carry[2]), .sum(sum_bit[3]), .carry(carry[3]));

	// assign overflow bit
	assign sum[4] = carry[3];

	// connect sum bits
	assign sum[3:0] = sum_bit[3:0];

endmodule
module FullAdder (
	input a,
	input b,
	input cin,
	output sum,
	output cout
);

	assign {cout, sum} = a + b + cin;

endmodule
module FourBitFullAdder (
	input [3:0] x,
	input [3:0] y,
	input cin,
	output [3:0] sum,
	output cout
);

	wire [3:0] carry;

	// instantiate 4 full adders
	FullAdder fa1 (.a(x[0]), .b(y[0]), .cin(cin), .sum(sum[0]), .cout(carry[0]));
	FullAdder fa2 (.a(x[1]), .b(y[1]), .cin(carry[0]), .sum(sum[1]), .cout(carry[1]));
	FullAdder fa3 (.a(x[2]), .b(y[2]), .cin(carry[1]), .sum(sum[2]), .cout(carry[2]));
	FullAdder fa4 (.a(x[3]), .b(y[3]), .cin(carry[2]), .sum(sum[3]), .cout(carry[3]));

	// assign overflow bit
	assign cout = carry[3];

endmodule
