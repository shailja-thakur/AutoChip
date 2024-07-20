module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

	// y[6:1] encodes the states A(000001), B(000010), C(000100), D(001000), E(010000), F(100000)
	// Next-state Y2 corresponds to state B (000010)
	// Next-state Y4 corresponds to state D (001000)

	// Logic for Y2: next state B
	assign Y2 = (y[1] & ~w) | (y[2] & ~w);

	// Logic for Y4: next state D
	assign Y4 = (y[2] & w) | (y[3] & w) | (y[4] & w) | (y[5] & w) | (y[6] & w);

endmodule
