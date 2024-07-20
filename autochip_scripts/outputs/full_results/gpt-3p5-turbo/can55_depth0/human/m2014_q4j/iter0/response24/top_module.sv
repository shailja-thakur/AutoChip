module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

// Declare the internal signals
wire [3:0] carry;
wire [3:0] sum_temp;

// Instantiate the full adders
full_adder FA0 (.x(x[0]), .y(y[0]), .cin(0), .sum(sum_temp[0]), .cout(carry[0]));
full_adder FA1 (.x(x[1]), .y(y[1]), .cin(carry[0]), .sum(sum_temp[1]), .cout(carry[1]));
full_adder FA2 (.x(x[2]), .y(y[2]), .cin(carry[1]), .sum(sum_temp[2]), .cout(carry[2]));
full_adder FA3 (.x(x[3]), .y(y[3]), .cin(carry[2]), .sum(sum_temp[3]), .cout(carry[3]));

// Output the sum and overflow bit
assign sum[0] = carry[3];
assign sum[1:4] = sum_temp;

endmodule
module full_adder (
	input x,
	input y,
	input cin,
	output sum,
	output cout
);

// Implement the full adder logic
assign sum = x ^ y ^ cin;
assign cout = (x & y) | (x & cin) | (y & cin);

endmodule
