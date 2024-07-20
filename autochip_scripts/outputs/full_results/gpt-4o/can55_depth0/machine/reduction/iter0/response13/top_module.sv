module top_module (
	input [7:0] in,
	output parity
);
	assign parity = ^in; // perform bitwise XOR on all bits of the input
endmodule
