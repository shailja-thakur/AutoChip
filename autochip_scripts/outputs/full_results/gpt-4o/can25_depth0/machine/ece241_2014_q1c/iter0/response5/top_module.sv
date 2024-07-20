module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	wire [8:0] sum;

	// Calculate the 9-bit sum of inputs a and b
	assign sum = a + b;

	// Assign the lowest 8 bits to the output s
	assign s = sum[7:0];

	// Calculate overflow: same sign for a and b, different sign for the sum result
	assign overflow = (~a[7] & ~b[7] & sum[8]) | (a[7] & b[7] & ~sum[8]);

endmodule
