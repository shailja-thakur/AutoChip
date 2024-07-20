module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

	// Declare the internal wire for the sum
	wire [8:0] sum;

	// Declare the wire for the overflow flag
	wire overflowFlag;

	// Add the two numbers
	assign sum = a + b;

	// Check for overflow
	assign overflow = (a[7] & b[7] & ~sum[7]) | (~a[7] & ~b[7] & sum[7]);

	// Assign the sum to the output
	assign s[7:0] = sum[7:0];

endmodule
