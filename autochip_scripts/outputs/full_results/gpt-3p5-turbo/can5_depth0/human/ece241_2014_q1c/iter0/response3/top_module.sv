module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Wire declaration
	wire [8:0] sum;
	wire carry_out;

	// Adder with carry bit
	assign {carry_out, sum} = a + b;

	// Output assignment
	assign s = sum[7:0];
	assign overflow = (sum[8] != sum[7]);

endmodule
