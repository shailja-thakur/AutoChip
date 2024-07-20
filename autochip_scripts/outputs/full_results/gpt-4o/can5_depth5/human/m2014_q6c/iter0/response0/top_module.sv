module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

	// Next-state logic for Y2: y[2] corresponds to state B
	assign Y2 = (y[1] & w) | (y[6] & w);

	// Next-state logic for Y4: y[4] corresponds to state D
	assign Y4 = (y[2] & w) | (y[3] & w) | (y[6] & ~w);

endmodule
