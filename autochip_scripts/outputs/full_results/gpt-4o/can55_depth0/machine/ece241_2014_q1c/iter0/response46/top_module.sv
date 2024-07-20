module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Internal wire to hold the full sum
	wire [8:0] full_sum;

	// Calculate the sum
	assign full_sum = a + b;

	// Assign the 8-bit output to the least significant 8 bits of the sum
	assign s = full_sum[7:0];

	// Determine overflow based on the sign bits
	assign overflow = (a[7] == b[7]) && (a[7] != full_sum[7]);

endmodule
