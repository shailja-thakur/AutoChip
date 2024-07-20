module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Intermediate wire to hold the sum of a and b
	wire [8:0] sum_full;

	// Sum of inputs
	assign sum_full = {1'b0, a} + {1'b0, b};

	// Assign the lower 8 bits to the output
	assign s = sum_full[7:0];

	// Determine overflow by checking the carry out of the MSB
	assign overflow = (a[7] & b[7] & ~sum_full[8]) | (~a[7] & ~b[7] & sum_full[8]);

endmodule
