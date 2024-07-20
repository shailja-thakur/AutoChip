module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

	// Deriving the logic for Y2 and Y4 based on the state transitions and one-hot encoding
	
	// Y2 logic: This signal corresponds to state B, which is y[2]
	// B (y[2]) is reached from:
	// - A (y[1]) on input w=0
	assign Y2 = y[1] & ~w;
	
	// Y4 logic: This signal corresponds to state D, which is y[4]
	// D (y[4]) is reached from:
	// - B (y[2]) on input w=1
	// - C (y[3]) on input w=1
	// - F (y[6]) on input w=1
	assign Y4 = (y[2] & w) | (y[3] & w) | (y[6] & w);
	
endmodule
