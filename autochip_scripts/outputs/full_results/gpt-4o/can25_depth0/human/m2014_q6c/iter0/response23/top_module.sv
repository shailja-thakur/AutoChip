module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

	// States encoding:
	// A: 000001
	// B: 000010
	// C: 000100
	// D: 001000
	// E: 010000
	// F: 100000

	// Next-state logic for Y2 (state B)
	assign Y2 = (y[1] & ~w) | (y[6] & ~w);

	// Next-state logic for Y4 (state D)
	assign Y4 = (y[2] & w) | (y[3] & w) | (y[4] & w) | (y[5] & w);

endmodule
