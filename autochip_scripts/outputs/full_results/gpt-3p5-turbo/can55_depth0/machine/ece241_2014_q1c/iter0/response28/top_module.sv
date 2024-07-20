module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	wire [8:0] sum; // Adding an extra bit for overflow detection

	// Assigning sum as the sum of a and b
	assign sum = a + b;

	// Assigning s to the 8 least significant bits of sum
	assign s = sum[7:0];

	// Assigning overflow to the appropriate conditions
	assign overflow = (a[7] == b[7]) && (a[7] != sum[7]);

endmodule
