module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
	
	// Wire variable to store the intermediate sum
	wire [8:0] sum_ext;
	
	// Compute the sum of a and b with an extra bit for carrying overflow
	assign sum_ext = a + b;
	
	// Assign the lower 8 bits of the sum to the output s
	assign s = sum_ext[7:0];
	
	// Check if overflow has occurred
	assign overflow = (a[7] & b[7] & ~sum_ext[8]) | (~a[7] & ~b[7] & sum_ext[8]);

endmodule
