module top_module (
	input [7:0] in,
	output parity
);

	// The output of the circuit is the XOR of all input bits
	assign parity = ^in;

endmodule
