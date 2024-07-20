module top_module (
	input [7:0] in,
	output parity
);

    assign parity = ^in; // XOR of all bits in 'in' (even parity)

endmodule
