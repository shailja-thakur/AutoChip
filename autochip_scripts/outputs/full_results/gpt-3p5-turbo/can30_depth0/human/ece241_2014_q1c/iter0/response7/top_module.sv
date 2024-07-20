module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Intermediate signal to hold the sum
	wire [7:0] sum;

	// Intermediate signal to hold the carry out
	wire carry_out;

	// Assign the sum and carry out signals
	assign sum = a + b;
	assign carry_out = (a[7] & b[7]) | (~sum[7] & (a[7] | b[7]));

	// Assign the output signals
	assign s = sum;
	assign overflow = (a[7] & b[7] & ~sum[7]) | (~a[7] & ~b[7] & sum[7]);

endmodule
