module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Intermediate wire to hold the sum of a and b
	wire [8:0] sum;

	// Calculate the sum of a and b
	assign sum = a + b;

	// Assign the 8-bit result to output s
	assign s = sum[7:0];

	// Check for overflow conditions
	assign overflow = (a[7] & b[7] & ~sum[7]) | (~a[7] & ~b[7] & sum[7]);

endmodule
