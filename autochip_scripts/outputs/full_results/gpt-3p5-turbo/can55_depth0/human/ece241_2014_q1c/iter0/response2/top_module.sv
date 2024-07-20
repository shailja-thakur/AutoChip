module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Wires
	wire [7:0] sum;
	wire carry;

	// 2's complement addition
	assign sum = a + b;
	assign carry = (a[7] & b[7]) | (a[7] & ~sum[7]) | (b[7] & ~sum[7]);

	// Output connections
	assign s = sum;
	assign overflow = carry;

endmodule
