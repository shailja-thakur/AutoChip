module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

	// State machine logic equations

	assign Y2 = ~y[6] & ~y[5] & y[4] & (~y[3] | ~y[2]) & ~w;
	assign Y4 = ~y[6] & ~y[5] & ~y[4] & w & (~y[3] | ~y[2]);

endmodule
