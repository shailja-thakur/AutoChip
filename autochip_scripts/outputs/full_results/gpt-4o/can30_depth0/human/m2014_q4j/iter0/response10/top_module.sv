module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

	wire c1, c2, c3, carry_out;

	// Full adders for each bit
	full_adder fa0 (x[0], y[0], 1'b0, sum[0], c1);
	full_adder fa1 (x[1], y[1], c1, sum[1], c2);
	full_adder fa2 (x[2], y[2], c2, sum[2], c3);
	full_adder fa3 (x[3], y[3], c3, sum[3], carry_out);

	assign sum[4] = carry_out; // Overflow bit

endmodule
module full_adder (
	input a,
	input b,
	input cin,
	output sum,
	output cout
);
	assign sum = a ^ b ^ cin;
	assign cout = (a & b) | (b & cin) | (cin & a);

endmodule
