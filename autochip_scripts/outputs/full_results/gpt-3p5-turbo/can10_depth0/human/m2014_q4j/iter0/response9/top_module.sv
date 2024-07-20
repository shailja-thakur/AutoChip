module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

	// Internal signals
	wire [3:0] carry;
	wire [3:0] xor_out;
	wire [3:1] and_out;
	wire [3:0] sum_out;

	// Full adders for each bit
	full_adder fa0(
		.x(x[0]),
		.y(y[0]),
		.carry_in(1'b0),
		.sum(sum_out[0]),
		.carry_out(carry[0])
	);

	full_adder fa1(
		.x(x[1]),
		.y(y[1]),
		.carry_in(carry[0]),
		.sum(sum_out[1]),
		.carry_out(carry[1])
	);

	full_adder fa2(
		.x(x[2]),
		.y(y[2]),
		.carry_in(carry[1]),
		.sum(sum_out[2]),
		.carry_out(carry[2])
	);

	full_adder fa3(
		.x(x[3]),
		.y(y[3]),
		.carry_in(carry[2]),
		.sum(sum_out[3]),
		.carry_out(carry[3])
	);

	// Generate outputs
	assign sum = {carry[3], sum_out};

endmodule
module full_adder (
	input x,
	input y,
	input carry_in,
	output sum,
	output carry_out
);

	// Internal signals
	wire xor1;
	wire xor2;
	wire and1;
	wire and2;

	// Calculate XOR and AND
	assign xor1 = x ^ y;
	assign xor2 = xor1 ^ carry_in;
	assign and1 = x & y;
	assign and2 = xor1 & carry_in;

	// Generate outputs
	assign sum = xor2;
	assign carry_out = and1 | and2;

endmodule
