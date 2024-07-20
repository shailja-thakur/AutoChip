module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
	// Intermediate wire to store sum
	wire [8:0] sum;

	// Calculate the sum of a and b (9 bits to capture overflow)
	assign sum = a + b;

	// Assign the lower 8 bits of sum to s
	assign s = sum[7:0];

	// Check for overflow: If the signs of a and b are the same but different from the sign of the sum
	assign overflow = ((a[7] == b[7]) && (s[7] != a[7]));

endmodule
