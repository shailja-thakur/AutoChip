module top_module (
	input [7:0] in,
	output parity
);

	// Parity checking logic
	assign parity = ^in;

endmodule
