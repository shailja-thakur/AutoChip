module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

wire [3:0] carry;
wire [3:0] carry_out;

full_adder FA0(.a(x[0]), .b(y[0]), .carry_in(0), .sum(sum[0]), .carry(carry[0]));
full_adder FA1(.a(x[1]), .b(y[1]), .carry_in(carry[0]), .sum(sum[1]), .carry(carry[1]));
full_adder FA2(.a(x[2]), .b(y[2]), .carry_in(carry[1]), .sum(sum[2]), .carry(carry[2]));
full_adder FA3(.a(x[3]), .b(y[3]), .carry_in(carry[2]), .sum(sum[3]), .carry(carry[3]));

assign carry_out = carry[3];

endmodule
module full_adder (
	input a,
	input b,
	input carry_in,
	output sum,
	output carry
);

	assign sum = a ^ b ^ carry_in;
	assign carry = (a & b) | (carry_in & (a ^ b));

endmodule
