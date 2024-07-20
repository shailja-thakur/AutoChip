module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

	wire [3:0] carry;
	wire [3:0] sum_temp;

	// Instantiate full adders for each bit
	full_adder full_adder_0 (.x(x[0]), .y(y[0]), .cin(0), .sum(sum_temp[0]), .cout(carry[0]));
	full_adder full_adder_1 (.x(x[1]), .y(y[1]), .cin(carry[0]), .sum(sum_temp[1]), .cout(carry[1]));
	full_adder full_adder_2 (.x(x[2]), .y(y[2]), .cin(carry[1]), .sum(sum_temp[2]), .cout(carry[2]));
	full_adder full_adder_3 (.x(x[3]), .y(y[3]), .cin(carry[2]), .sum(sum_temp[3]), .cout(carry[3]));

	// Concatenate sum_temp and carry to get the final sum
	assign sum = {carry[3], sum_temp[3:0]};

endmodule
module full_adder (
	input x,
	input y,
	input cin,
	output sum,
	output cout
);

	assign sum = x ^ y ^ cin;
	assign cout = (x & y) | (x & cin) | (y & cin);

endmodule
