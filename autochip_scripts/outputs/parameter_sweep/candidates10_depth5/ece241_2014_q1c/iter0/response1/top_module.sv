module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Internal wire to hold intermediate result
	wire [8:0] sum;

	// Intermediate wire to store carryout
	wire carryout;

	// Internal wire to hold sign bit of a and b
	wire sign_a, sign_b;

	// Intermediate wire to store overflow
	wire overflow;

	// Intermediate wire to store sign bit of sum
	wire sign_sum; 

	// Assigning sign bits of a and b
	assign sign_a = a[7];
	assign sign_b = b[7];

	// Calculating sum of a and b
	assign sum = a + b;

	// Assigning sign bit of sum
	assign sign_sum = sum[8];

	// Calculating carryout
	assign carryout = sum[8];

	// Assigning s to lower 8 bits of sum
	assign s = sum[7:0];

	// Calculating overflow
	assign overflow = (sign_a == sign_b) && (sign_a != sign_sum);

endmodule
