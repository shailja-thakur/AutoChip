module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

	// State A
	assign Y2 = (y[1] & ~w) | (y[4] & w);
	assign Y4 = (y[2] & ~w) | (y[5] & w);

endmodule
