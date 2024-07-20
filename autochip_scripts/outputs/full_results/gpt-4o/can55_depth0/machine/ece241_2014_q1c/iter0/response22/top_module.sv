module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Intermediate wire to store the sum
	wire [8:0] sum;

	// Calculate the sum of the inputs
	assign sum = a + b;

	// Assign the lower 8 bits of the sum to s
	assign s = sum[7:0];

	// Check for overflow
	assign overflow = ((a[7] == b[7]) && (sum[8] != a[7]));

endmodule
