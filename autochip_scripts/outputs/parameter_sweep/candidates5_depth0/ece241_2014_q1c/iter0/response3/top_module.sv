module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
	// Wire for carry output
	wire carry_out;

	// Wire for overflow output
	wire overflow;

	// Instantiate the adder module
	adder_module adder1(
		.a(a),
		.b(b),
		.s(s),
		.carry_out(carry_out)
	);

	// Check for overflow
	assign overflow = ((a[7] & b[7] & ~s[7]) | (~a[7] & ~b[7] & s[7]));

endmodule
module adder_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output carry_out
);
	// Wires for individual bits
	wire [7:0] carry;
	wire [7:0] sum;

	// Generate carry and sum by using ripple carry adders
	genvar i;
	generate
		for (i = 0; i < 8; i = i + 1) begin: adder_gen
			ripple_carry_adder adder(
				.a(a[i]),
				.b(b[i]),
				.carry_in(carry[i]),
				.sum(sum[i]),
				.carry_out(carry[i + 1])
			);
		end
	endgenerate

	// Assign sum and carry_out
	assign s = sum;
	assign carry_out = carry[8];

endmodule
module ripple_carry_adder (
	input a,
	input b,
	input carry_in,
	output sum,
	output carry_out
);
	// Perform addition for each bit
	assign sum = a ^ b ^ carry_in;

	// Calculate carry_out
	assign carry_out = (a & b) | (carry_in & (a ^ b));

endmodule
