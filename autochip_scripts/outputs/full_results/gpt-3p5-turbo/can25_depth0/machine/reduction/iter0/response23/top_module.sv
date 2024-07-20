module top_module (
	input [7:0] in,
	output parity
);
	// Assign the output port "parity" to the bitwise xor of the input port "in"
	assign parity = ^in;

endmodule
