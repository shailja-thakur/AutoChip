module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

wire [3:0] carry;
wire [4:0] sum_with_carry;

full_adder fa0 (
	.x(x[0]),
	.y(y[0]),
	.cin(0),
	.sum(sum[0]),
	.cout(carry[0])
);
full_adder fa1 (
	.x(x[1]),
	.y(y[1]),
	.cin(carry[0]),
	.sum(sum[1]),
	.cout(carry[1])
);
full_adder fa2 (
	.x(x[2]),
	.y(y[2]),
	.cin(carry[1]),
	.sum(sum[2]),
	.cout(carry[2])
);
full_adder fa3 (
	.x(x[3]),
	.y(y[3]),
	.cin(carry[2]),
	.sum(sum[3]),
	.cout(carry[3])
);

assign sum[4] = carry[3];
assign sum_with_carry = {carry, sum};
assign sum = sum_with_carry;

endmodule
