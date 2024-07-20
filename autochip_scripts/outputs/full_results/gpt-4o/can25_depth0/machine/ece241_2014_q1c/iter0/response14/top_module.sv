module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
	wire [8:0] sum; // Create a 9-bit wire to hold the sum including carry bit

	assign sum = a + b; // Perform addition
	assign s = sum[7:0]; // Assign the lower 8 bits to output s

	// Check for overflow: if a and b have the same sign and s has a different sign
	assign overflow = (a[7] == b[7]) && (a[7] != sum[7]);

endmodule
