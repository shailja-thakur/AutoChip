module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
	wire [8:0] sum; // Create a 9-bit wire to accommodate possible overflow.

	assign sum = a + b; // Calculate the sum of inputs a and b.
	assign s = sum[7:0]; // Assign the 8 least significant bits of sum to output s.

	// Check for overflow: if the sign bits of inputs a and b are the same
	// and the sign bit of the result is different.
	assign overflow = (~a[7] & ~b[7] & sum[7]) | (a[7] & b[7] & ~sum[7]);

endmodule
