module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
	// Wire declaration for sum
	wire [7:0] sum;

	// Assigning s to the 8 least significant bits of the sum
	assign s = sum[7:0];

	// Assigning overflow output based on logical expression
	assign overflow = (a[7] == b[7]) && (a[7] != sum[7]);
	endmodule
