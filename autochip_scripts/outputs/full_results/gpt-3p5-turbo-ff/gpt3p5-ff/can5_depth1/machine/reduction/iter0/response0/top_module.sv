module top_module (
	input [7:0] in,
	output parity
);

	// Assigning the output port "parity" to the bitwise XOR of the input port "in"
	assign parity = ^in;

endmodule
