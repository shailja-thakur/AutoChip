module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Intermediate sum wire
	wire [8:0] sum;

	// Calculating the sum of a and b
	assign sum = a + b;

	// Assigning the 8 least significant bits of sum to output s
	assign s = sum[7:0];

	// Calculating overflow
	assign overflow = (a[7] & b[7] & ~sum[7]) | (~a[7] & ~b[7] & sum[7]);

endmodule
