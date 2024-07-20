module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Internal wire for the summation of a and b
	wire [8:0] sum; // 9-bit to accommodate overflow

	// Sum the 8-bit inputs a and b
	assign sum = a + b;

	// Assign the lower 8 bits of the sum to s
	assign s = sum[7:0];

	// Determine the overflow: overflow occurs if the sign bit of (a and b) 
	// are the same and differ from the sign bit of the result s
	assign overflow = (a[7] & b[7] & ~sum[7]) | (~a[7] & ~b[7] & sum[7]);

endmodule
