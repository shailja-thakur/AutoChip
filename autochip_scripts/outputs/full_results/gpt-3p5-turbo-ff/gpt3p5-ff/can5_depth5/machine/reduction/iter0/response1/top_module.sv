module top_module (
	input [7:0] in,
	output parity
);

// Parity Logic
assign parity = ^in;

endmodule
