module top_module (
	input [7:0] in,
	output parity
);

    assign parity = ^in; // XOR all input bits to calculate even parity

endmodule
