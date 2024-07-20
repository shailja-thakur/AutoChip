module top_module (
	input [7:0] in,
	output parity
);

assign parity = ^in; // XOR all input bits for even parity

endmodule
