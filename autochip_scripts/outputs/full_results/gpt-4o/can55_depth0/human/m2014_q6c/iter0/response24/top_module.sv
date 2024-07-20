module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

	// State assignment
	// y[6:1] = 000001 -> State A
	// y[6:1] = 000010 -> State B
	// y[6:1] = 000100 -> State C
	// y[6:1] = 001000 -> State D
	// y[6:1] = 010000 -> State E
	// y[6:1] = 100000 -> State F

	// Deriving next state logic by inspection
	
	// Y2 corresponds to state B
	// B's transitions: A--0-->B (y[1] & ~w) 
	// Y2 = y[1] & ~w;
	assign Y2 = y[1] & ~w;

	// Y4 corresponds to state D
	// D's transitions: B--1-->D (y[2] & w) + C--1-->D (y[3] & w) + F--1-->D (y[6] & w) 
	// Y4 = (y[2] & w) | (y[3] & w) | (y[6] & w);
	assign Y4 = (y[2] & w) | (y[3] & w) | (y[6] & w);

endmodule
