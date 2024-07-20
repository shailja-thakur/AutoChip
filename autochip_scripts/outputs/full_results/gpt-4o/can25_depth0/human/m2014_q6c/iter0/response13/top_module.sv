module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

	// Determine the next state Y2 and Y4 based on current state y and input w
	assign Y2 = (y[1] & ~w) | (y[2] & ~w) | (y[4] & w) | (y[6] & ~w);
	assign Y4 = (y[2] & w) | (y[3] & w) | (y[4] & ~w) | (y[5] & w) | (y[6] & w);

endmodule
