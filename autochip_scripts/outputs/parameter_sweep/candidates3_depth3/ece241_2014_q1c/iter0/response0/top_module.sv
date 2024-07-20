module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Internal wire to hold the intermediate sum
	wire [8:0] sum;

	// Assign the sum of a and b to sum
	assign sum = a + b;

	// Assign the lower 8 bits of sum to s
	assign s = sum[7:0];

	// Assign overflow based on whether a signed overflow occurred
	assign overflow = (a[7] == b[7] && sum[8] != sum[7]);

endmodule
