module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Intermediate wires
	wire [8:0] sum;

	// Adder
	assign sum = a + b;

	// Output the sum
	assign s = sum[7:0];

	// Detect overflow
	assign overflow = sum[8];

endmodule
