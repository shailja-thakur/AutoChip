module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

wire [3:0] carry;
wire [4:0] sum_temp;

// Full Adder1
full_adder FA1(
	.x(x[0]),
	.y(y[0]),
	.cin(1'b0),
	.sum(sum_temp[0]),
	.carry(carry[0])
);

// Full Adder2
full_adder FA2(
	.x(x[1]),
	.y(y[1]),
	.cin(carry[0]),
	.sum(sum_temp[1]),
	.carry(carry[1])
);

// Full Adder3
full_adder FA3(
	.x(x[2]),
	.y(y[2]),
	.cin(carry[1]),
	.sum(sum_temp[2]),
	.carry(carry[2])
);

// Full Adder4
full_adder FA4(
	.x(x[3]),
	.y(y[3]),
	.cin(carry[2]),
	.sum(sum_temp[3]),
	.carry(carry[3])
);

// Output
assign sum = {carry[3], sum_temp};

endmodule
