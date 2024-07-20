module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Internal wire to hold the sum of a and b
	wire [8:0] sum;

	// Calculate the sum of a and b, using an extra bit to detect overflow
	assign sum = a + b;

	// Assign the 8 least significant bits of the sum to the output s
	assign s = sum[7:0];

	// Determine the overflow
	assign overflow = (a[7] & b[7] & ~sum[7]) | (~a[7] & ~b[7] & sum[7]);

endmodule
