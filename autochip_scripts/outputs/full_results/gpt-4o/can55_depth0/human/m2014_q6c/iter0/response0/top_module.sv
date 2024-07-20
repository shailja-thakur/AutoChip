module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

	// Next state Y2 corresponds to state B
	// Equation for Y2: Y2 = (y[1] & ~w) | (y[4] & ~w)
	assign Y2 = (y[1] & ~w) | (y[4] & ~w);

	// Next state Y4 corresponds to state D
	// Equation for Y4: Y4 = (y[2] & w) | (y[3] & w) | (y[6] & w)
	assign Y4 = (y[2] & w) | (y[3] & w) | (y[6] & w);

endmodule
