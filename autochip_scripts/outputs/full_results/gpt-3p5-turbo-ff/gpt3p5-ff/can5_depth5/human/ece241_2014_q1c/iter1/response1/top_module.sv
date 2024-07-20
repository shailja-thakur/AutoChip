module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Wire declaration for intermediate signals
	wire [8:0] sum;
	wire carry;

	// Adder
	assign sum = a + b;
	assign s = sum[7:0];
	assign carry = sum[8];

	// Overflow detection
	assign overflow = (a[7] & b[7] & ~sum[7]) | (~a[7] & ~b[7] & sum[7]);

endmodule
