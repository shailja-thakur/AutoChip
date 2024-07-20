module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

	// Declare internal signals
	wire A, B, C, D, E, F;
	
	// Determine the next state based on the current state and input
	assign A = ~y[6] & ~y[5] & ~y[4] & ~y[3] & ~y[2] & ~y[1] & ~w;
	assign B = ~y[6] & ~y[5] & ~y[4] & ~y[3] & ~y[2] &  y[1] & ~w;
	assign C = ~y[6] & ~y[5] & ~y[4] & ~y[3] &  y[2] & ~y[1] & ~w;
	assign D = ~y[6] & ~y[5] & ~y[4] & ~y[3] &  y[2] &  y[1] & ~w;
	assign E = ~y[6] & ~y[5] &  y[4] & ~y[3] & ~y[2] & ~y[1] & w;
	assign F = ~y[6] & ~y[5] &  y[4] & ~y[3] & ~y[2] &  y[1] & w;
	
	// Output the next-state signals
	assign Y2 = B | D | E;
	assign Y4 = C | D | F;
	
endmodule
