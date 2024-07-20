module top_module (
	input [7:0] in,
	output parity
);

	// Parity checker logic
	assign parity = ^in;

endmodule
