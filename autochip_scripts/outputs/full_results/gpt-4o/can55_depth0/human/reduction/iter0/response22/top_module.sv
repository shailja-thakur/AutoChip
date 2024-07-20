module top_module (
	input [7:0] in,
	output parity
);

    // Compute even parity: XOR all the bits together
    assign parity = ^in; // ^ is the reduction XOR operator

endmodule
