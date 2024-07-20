module top_module (
	input [2:0] in,
	output [1:0] out
);

	// Internal wire to hold the sum of the bits
	wire [1:0] sum;

	// Add the three input bits together
	assign sum = in[2] + in[1] + in[0];

	// Assign the sum to the outputs
	assign out = sum;

endmodule
