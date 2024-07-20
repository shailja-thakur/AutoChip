module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

	// Logic for Y1 (State B)
	assign Y1 = (y[0] & w); // Transition from state A to state B on input w=1

	// Logic for Y3 (State D)
	assign Y3 = (y[1] & ~w) | // Transition from state B to state D on input w=0
	            (y[2] & ~w) | // Transition from state C to state D on input w=0
	            (y[5] & ~w);  // Transition from state F to state D on input w=0

endmodule
