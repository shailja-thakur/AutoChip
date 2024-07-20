module top_module (
	input [7:0] in,
	output parity
);
	// Calculate the XOR of all input bits
	assign parity = ^in;

endmodule
