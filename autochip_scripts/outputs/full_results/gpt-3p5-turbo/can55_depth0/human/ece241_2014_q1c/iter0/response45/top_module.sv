module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Wire to store the sum of a and b
	wire [8:0] sum;
	
	// Wire to store the sign of a and b
	wire sign_a;
	wire sign_b;

	// Sign bit of a
	assign sign_a = a[7];

	// Sign bit of b
	assign sign_b = b[7];

	// Signed sum of a and b including the carry-out
	assign sum = a + b;

	// If the signs of a and b are same, there can be overflow if sign of sum is different
	// If the signs of a and b are different, there can be no overflow
	assign overflow = (sign_a == sign_b) ? (sum[8] != sign_a) : 1'b0;

	// Output sum
	assign s = sum[7:0];

endmodule
