module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// wires to calculate the binary addition of a and b
	wire [8:0] sum;
	wire carry;

	// wire to check for overflow
	wire sign_a;
	wire sign_b;
	wire sign_s;

	// assign the sign of a, b, and s
	assign sign_a = a[7];
	assign sign_b = b[7];
	assign sign_s = s[7];

	// wire to check for overflow
	assign overflow = (sign_a == sign_b) && (sign_s != sign_a);

	// binary addition
	assign {carry, sum} = a + b;

	// discard the carry
	assign s = sum[7:0];

endmodule
