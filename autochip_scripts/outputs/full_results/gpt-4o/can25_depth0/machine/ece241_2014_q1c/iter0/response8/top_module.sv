module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	wire [8:0] sum;  // 9-bit wire to hold the sum of a and b including the carry out bit

	assign sum = a + b;  // Perform addition and store result in sum
	assign s = sum[7:0];  // Assign the lower 8 bits of sum to the output s

	// Check for overflow: if the sign bits of a and b are the same,
	// and the sign bit of the result is different from the sign bits of a and b
	assign overflow = (a[7] == b[7]) && (a[7] != sum[7]);

endmodule
