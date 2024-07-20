module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
	// Wire to hold the result of the addition
	wire signed [8:0] sum;

	// Perform addition
	assign sum = {a[7], a} + {b[7], b};

	// Assign lower 8 bits to the sum output
	assign s = sum[7:0];

	// Check for overflow: occurred if the 8th and 9th bit of sum differ
	assign overflow = (a[7] == b[7]) && (a[7] != sum[8]);

endmodule
