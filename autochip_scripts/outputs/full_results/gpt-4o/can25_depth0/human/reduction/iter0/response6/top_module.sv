module top_module (
	input [7:0] in,
	output parity
);

	assign parity = ^in;  // XOR all the bits together to get even parity

endmodule
