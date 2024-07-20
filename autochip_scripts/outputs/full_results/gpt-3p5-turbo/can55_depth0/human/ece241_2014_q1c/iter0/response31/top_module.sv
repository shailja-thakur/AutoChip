module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
	// Declare internal wires and registers
	wire [8:0] sum;
	reg overflow;

	// Assign overflow
	assign overflow = (a[7] & b[7] & ~sum[8]) | (~a[7] & ~b[7] & sum[8]);

	// Adder logic
	assign sum = a + b;

	// Assign sum to output
	assign s = sum[7:0];
endmodule
