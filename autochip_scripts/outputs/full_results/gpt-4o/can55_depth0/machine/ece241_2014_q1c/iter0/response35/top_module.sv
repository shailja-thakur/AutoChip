module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Summing a and b
	wire [8:0] sum; // 9-bit wide to detect overflow
	assign sum = a + b;

	// Assign the sum to the 8-bit output
	assign s = sum[7:0];

	// Check for overflow
	assign overflow = (a[7] == b[7]) && (s[7] != a[7]);

endmodule
