module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

	// Define the signals for the full adders
	wire [3:0] carry_out;
	wire [3:0] sum_out;

	// Instantiate the full adders
	full_adder fa0(.x(x[0]), .y(y[0]), .cin(1'b0), .sum(sum_out[0]), .cout(carry_out[0]));
	full_adder fa1(.x(x[1]), .y(y[1]), .cin(carry_out[0]), .sum(sum_out[1]), .cout(carry_out[1]));
	full_adder fa2(.x(x[2]), .y(y[2]), .cin(carry_out[1]), .sum(sum_out[2]), .cout(carry_out[2]));
	full_adder fa3(.x(x[3]), .y(y[3]), .cin(carry_out[2]), .sum(sum_out[3]), .cout(carry_out[3]));

	// Assign the outputs
	assign sum = {carry_out[3], sum_out};

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
