module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Internal wires
	wire [8:0] sum;
	wire carry;

	// Adder
	assign sum = a + b;
	assign s = sum[7:0]; // Take only the LSBs

	// Overflow detection
	assign carry = sum[8];
	assign overflow = (a[7] == b[7]) && (a[7] != s[7]) && (carry != s[8]);

endmodule
