module top_module (
	input [7:0] in,
	output parity
);

    assign parity = ^in; // Using reduction XOR operator to compute parity

endmodule
