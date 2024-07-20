module top_module (
	input [2:0] in,
	output [1:0] out
);

	// Declare internal wire to store the sum of the input bits
	wire [2:0] sum;

	// Add the three input bits together
	assign sum = in[2] + in[1] + in[0];

	// Store the most significant bit of the sum in out[1]
	assign out[1] = sum[2];

	// Store the least significant bit of the sum in out[0]
	assign out[0] = sum[0];

endmodule
