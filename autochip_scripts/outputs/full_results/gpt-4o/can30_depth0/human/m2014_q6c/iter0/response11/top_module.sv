module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

	// Assign the next-state logic for Y2 (state B) and Y4 (state D)
	assign Y2 = (y[1] & ~w) | (y[2] & ~w) | (y[4] & ~w);
	assign Y4 = (y[2] & w) | (y[3] & w) | (y[4] & w) | (y[5] & w) | (y[6] & w);

endmodule
