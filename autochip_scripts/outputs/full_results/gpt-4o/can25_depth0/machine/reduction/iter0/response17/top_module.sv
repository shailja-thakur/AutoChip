module top_module (
	input [7:0] in,
	output parity
);

    assign parity = ^in; // Bitwise XOR reduction operator

endmodule
