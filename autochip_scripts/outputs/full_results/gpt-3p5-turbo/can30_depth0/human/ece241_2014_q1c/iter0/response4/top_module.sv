module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Wire declaration
	wire [7:0] sum;
	wire carry;

	// Adder definition
	assign {carry, sum} = a + b;

	// Overflow detection
	assign overflow = (a[7] == b[7] && a[7] != sum[7]) ? 1'b1 : 1'b0;

	// Output assignment
	assign s = sum;

endmodule
