module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Intermediate wire to store the full sum
	wire [8:0] full_sum;

	// Calculate the full sum
	assign full_sum = a + b;

	// Assign the least significant 8 bits to s
	assign s = full_sum[7:0];

	// Determine if there is an overflow
	assign overflow = (a[7] == b[7]) && (a[7] != s[7]);

endmodule
