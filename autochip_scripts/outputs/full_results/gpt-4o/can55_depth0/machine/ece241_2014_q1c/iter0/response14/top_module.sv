module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Create a wire for the sum of a and b
	wire [8:0] sum = {1'b0, a} + {1'b0, b};

	// Assign the 8 least significant bits of sum to the output s
	assign s = sum[7:0];

	// Check for overflow: If the signs of a and b are the same, but different from the sign of the sum
	assign overflow = (a[7] == b[7]) && (a[7] != sum[7]);

endmodule
