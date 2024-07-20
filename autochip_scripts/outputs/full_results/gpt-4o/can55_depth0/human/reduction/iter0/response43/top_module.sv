module top_module (
	input [7:0] in,
	output parity
);

    assign parity = ^in;  // XOR all the bits to get even parity

endmodule
