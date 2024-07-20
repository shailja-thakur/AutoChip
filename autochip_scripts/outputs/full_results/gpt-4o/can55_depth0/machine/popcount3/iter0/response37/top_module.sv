module top (
	input [2:0] in,
	output [1:0] out
);

	// Intermediate wire to store the sum
	wire [2:0] sum;

	// Calculate the sum of the input bits
	assign sum = in[0] + in[1] + in[2];

	// Assign the most significant and least significant bits of the sum to the output
	assign out = sum[1:0];

endmodule
