module top_module (
	input [7:0] in,
	output parity
);

	// Compute even parity by XORing all 8 bits
	assign parity = ^in;

endmodule
