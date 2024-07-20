module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	wire [8:0] sum; // 9-bit wire to store the sum with carry bit

	assign sum = a + b; // Perform the addition

	assign s = sum[7:0]; // The 8-bit result
	
	// Check the overflow condition: if a and b have the same sign, but sum has a different sign
	assign overflow = (~a[7] & ~b[7] & sum[8]) | (a[7] & b[7] & ~sum[8]);

endmodule
