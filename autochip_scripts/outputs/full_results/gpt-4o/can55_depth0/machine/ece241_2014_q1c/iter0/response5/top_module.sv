module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Intermediate wire to hold the full 9-bit sum
	wire [8:0] full_sum;

	// Perform the addition
	assign full_sum = a + b;

	// Assign the 8 least significant bits to s
	assign s = full_sum[7:0];

	// Check for overflow
	assign overflow = (a[7] == b[7]) && (a[7] != full_sum[7]);

endmodule
