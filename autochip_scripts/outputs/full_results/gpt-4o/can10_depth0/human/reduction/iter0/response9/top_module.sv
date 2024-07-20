module top_module (
	input [7:0] in,
	output parity
);

assign parity = ^in; // ^ is the reduction XOR operator

endmodule
