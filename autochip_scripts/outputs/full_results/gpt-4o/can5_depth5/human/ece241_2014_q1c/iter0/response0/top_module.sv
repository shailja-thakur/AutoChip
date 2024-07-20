module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
	// Internal wire to hold the signed sum
	wire [7:0] sum;
	
	// Assign the sum
	assign sum = a + b;
	assign s = sum;

	// Check for overflow: 
	// Overflow occurs if the sign of a and b are the same, but the sign of s is different from both a and b
	assign overflow = (~a[7] & ~b[7] & sum[7]) | (a[7] & b[7] & ~sum[7]);

endmodule
