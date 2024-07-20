module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

	// State assignments:
	// y = 000001 -> A
	// y = 000010 -> B
	// y = 000100 -> C
	// y = 001000 -> D
	// y = 010000 -> E
	// y = 100000 -> F

	assign Y1 = (y[0] & w) | (y[3] & ~w); // Y1 is 1 when Next state is B (0010)
	assign Y3 = (y[1] & ~w) | (y[2] & ~w) | (y[5] & ~w); // Y3 is 1 when Next state is D (1000)

endmodule
