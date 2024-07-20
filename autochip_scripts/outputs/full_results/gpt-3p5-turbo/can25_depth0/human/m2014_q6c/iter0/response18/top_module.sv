module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

	// State transition logic for Y2
	assign Y2 = (y[3] & w) | (y[1] & ~w);

	// State transition logic for Y4
	assign Y4 = (y[5] & ~w) | (y[3] & w);

endmodule
