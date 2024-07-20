module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

wire [3:0] carry; // Declare a wire to hold the carry bits

// Instantiate four full adders and connect their inputs and outputs
full_adder fa0 (
	.x(x[0]),
	.y(y[0]),
	.cin(1'b0),
	.sum(sum[0]),
	.carry(carry[0])
);

full_adder fa1 (
	.x(x[1]),
	.y(y[1]),
	.cin(carry[0]),
	.sum(sum[1]),
	.carry(carry[1])
);

full_adder fa2 (
	.x(x[2]),
	.y(y[2]),
	.cin(carry[1]),
	.sum(sum[2]),
	.carry(carry[2])
);

full_adder fa3 (
	.x(x[3]),
	.y(y[3]),
	.cin(carry[2]),
	.sum(sum[3]),
	.carry(sum[4]) // The overflow bit is the carry out of the fourth adder
);

endmodule
