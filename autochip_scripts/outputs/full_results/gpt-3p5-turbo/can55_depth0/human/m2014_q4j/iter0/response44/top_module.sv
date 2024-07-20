module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

	// Initialize carry bit
	reg carry = 0;

	// Instantiate full adders
	full_adder fa0 (.a(x[0]), .b(y[0]), .cin(carry), .sum(sum[0]), .cout(carry));
	full_adder fa1 (.a(x[1]), .b(y[1]), .cin(carry), .sum(sum[1]), .cout(carry));
	full_adder fa2 (.a(x[2]), .b(y[2]), .cin(carry), .sum(sum[2]), .cout(carry));
	full_adder fa3 (.a(x[3]), .b(y[3]), .cin(carry), .sum(sum[3]), .cout(sum[4]));

endmodule
module full_adder (
	input a,
	input b,
	input cin,
	output sum,
	output cout
);

	assign sum = a ^ b ^ cin;
	assign cout = (a & b) | (a & cin) | (b & cin);

endmodule
