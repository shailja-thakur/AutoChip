module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Internal wire to hold the sum
	wire [8:0] sum;

	// Add the two 8-bit numbers, a and b
	assign sum = a + b;

	// Assign the 8-bit output, s, to the 8 least significant bits of the sum
	assign s = sum[7:0];

	// Check for overflow: if a and b have the same sign and the sign of s is different
	assign overflow = (a[7] == b[7]) && (a[7] != sum[7]);

endmodule
