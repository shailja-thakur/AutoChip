module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

	assign Y1 = (y[0] & w) | (y[5] & w);  // Transition to state B (000010) from A (000001) on w=1 or from F (100000) on w=1
	assign Y3 = (y[1] & ~w) | (y[2] & ~w) | (y[3] & ~w) | (y[4] & ~w);  // Transition to state D (001000) from B (000010) on w=0, C (000100) on w=0, D (001000) on w=0, or E (010000) on w=0

endmodule
