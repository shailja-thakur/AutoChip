module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Internal wire to hold the full addition result
	wire [8:0] full_sum;

	// Add the two 8-bit inputs
	assign full_sum = a + b;

	// Assign the 8-bit output to the 8 least significant bits of the full_sum
	assign s = full_sum[7:0];

	// Determine the overflow condition
	assign overflow = (a[7] & b[7] & ~full_sum[8]) | (~a[7] & ~b[7] & full_sum[8]);

endmodule
