module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

	// One-hot state encoding for states A, B, C, D, E, F
	// State A = y[6:1] = 000001
	// State B = y[6:1] = 000010
	// State C = y[6:1] = 000100
	// State D = y[6:1] = 001000
	// State E = y[6:1] = 010000
	// State F = y[6:1] = 100000
	
	// Next state Y2 = B
	// Next state Y4 = D
	
	// Deriving Y2:
	// B is reached from A on w=0 and remains B on w=1 from itself
	// Y2 = (y[1] & ~w) | (y[2] & w)
	assign Y2 = (y[1] & ~w) | (y[2] & w);
	
	// Deriving Y4:
	// D can be reached from B on w=1, from C on w=1, from D on w=0 and from E on w=1
	// Y4 = (y[2] & w) | (y[3] & w) | (y[4] & ~w) | (y[5] & w)
	assign Y4 = (y[2] & w) | (y[3] & w) | (y[4] & ~w) | (y[5] & w);
	
endmodule
