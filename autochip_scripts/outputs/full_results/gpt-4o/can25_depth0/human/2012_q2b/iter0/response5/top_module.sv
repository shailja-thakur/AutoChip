module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

// State encoding
// y[5:0] = 000001(A), 000010(B), 000100(C), 001000(D), 010000(E), 100000(F)

// Determine Y1 and Y3 based on the state transitions
// For Y1 (next state B):
// Y1 = y[0] AND w

assign Y1 = y[0] & w;

// For Y3 (next state D):
// Y3 = (y[1] AND ~w) OR (y[2] AND ~w) OR (y[3] AND ~w) OR (y[4] AND ~w) OR (y[5] AND ~w)

assign Y3 = (y[1] & ~w) | (y[2] & ~w) | (y[3] & ~w) | (y[4] & ~w) | (y[5] & ~w);

endmodule
