module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

	// Create intermediate wires for the state transitions
	wire w1, w2, w3, w4, w5, w6;

	// Logic equations for Y2
	assign w1 = y[6] & ~y[2] & ~y[3] & ~y[4] & ~y[5] & ~w;
	assign w2 = ~y[6] & ~y[2] & y[3] & ~y[4] & ~y[5] & ~w;
	assign Y2 = w1 | w2;

	// Logic equations for Y4
	assign w3 = ~y[6] & ~y[2] & ~y[3] & ~y[4] & y[5] & ~w;
	assign w4 = y[6] & ~y[2] & ~y[3] & ~y[4] & ~y[5] & ~w;
	assign w5 = ~y[6] & y[2] & ~y[3] & y[4] & ~y[5] & ~w;
	assign w6 = y[6] & ~y[2] & ~y[3] & ~y[4] & ~y[5] & ~w;
	assign Y4 = w3 | w4 | w5 | w6;

endmodule
