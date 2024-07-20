module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Intermediate 9-bit wire to capture the sum and possible overflow
	wire [8:0] sum;

	// Calculate the sum of a and b
	assign sum = a + b;

	// Assign the least significant 8 bits to the output s
	assign s = sum[7:0];

	// Check for overflow
	assign overflow = ((a[7] == b[7]) && (s[7] != a[7]));

endmodule
