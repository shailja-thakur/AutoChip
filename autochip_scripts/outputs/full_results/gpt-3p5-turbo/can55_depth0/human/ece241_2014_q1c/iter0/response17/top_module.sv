module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Declare intermediate signal for overflow calculation
	wire [8:0] sum;

	// Add the two numbers
	assign sum = {1'b0, a} + {1'b0, b};

	// Assign the lower 8 bits of the sum to the output
	assign s = sum[7:0];

	// Calculate overflow based on sign bit of sum
	assign overflow = (sum[8] != (sum[7] ^ a[7] ^ b[7]));

endmodule
