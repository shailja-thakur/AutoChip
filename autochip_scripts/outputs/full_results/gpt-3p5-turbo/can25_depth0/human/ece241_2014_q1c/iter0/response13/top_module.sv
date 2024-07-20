module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Define internal wire for overflow
	wire overflow;

	// Adder module for adding a and b
	adder adder1(
		.a(a),
		.b(b),
		.sum(s),
		.overflow(overflow)
	);

endmodule
module adder (
	input [7:0] a,
	input [7:0] b,
	output [7:0] sum,
	output overflow
);

	// Internal wire for the sign of a and b
	wire sign_a;
	wire sign_b;

	// Get sign of a and b
	assign sign_a = a[7];
	assign sign_b = b[7];

	// Internal wire for extended a and b
	wire [8:0] extended_a;
	wire [8:0] extended_b;

	// Extend a and b with sign bit
	assign extended_a = {sign_a, a};
	assign extended_b = {sign_b, b};

	// Internal wire for extended sum
	wire [8:0] extended_sum;

	// Add extended a and b
	assign extended_sum = extended_a + extended_b;

	// Internal wire for sum with overflow
	wire [7:0] sum_with_overflow;

	// Extract sum from extended sum
	assign sum = extended_sum[7:0];

	// Check for overflow
	assign overflow = (extended_sum[8] != extended_sum[7]);

endmodule
