module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Internal wire to store the 8-bit sum
	wire [8:0] sum; // 9 bits to account for possible overflow

	// Assign the sum of a and b to the sum wire
	assign sum = a + b;

	// Assign the 8-bit result to output s
	assign s = sum[7:0];

	// Calculate the overflow condition
	assign overflow = (a[7] & b[7] & ~sum[7]) | (~a[7] & ~b[7] & sum[7]);

endmodule
