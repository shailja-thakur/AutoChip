module top_module (
	input [7:0] in,
	output parity
);

	// Declare a wire for each bit of the input data
	wire [7:0] in_bits;

	// Connect each input bit to its corresponding wire
	assign in_bits = in;

	// Compute the XOR of all input bits
	assign parity = ^in_bits;

endmodule
