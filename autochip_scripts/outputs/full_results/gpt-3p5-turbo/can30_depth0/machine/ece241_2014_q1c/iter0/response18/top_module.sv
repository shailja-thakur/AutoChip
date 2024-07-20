module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Define intermediate wire
	wire [7:0] sum;

	// Add two inputs
	assign sum = a + b;

	// Assign the 8 least significant bits of the sum to the output s
	assign s = sum[7:0];

	// Assign the overflow output
	assign overflow = (a[7] == b[7]) && (a[7] != s[7]);

endmodule
