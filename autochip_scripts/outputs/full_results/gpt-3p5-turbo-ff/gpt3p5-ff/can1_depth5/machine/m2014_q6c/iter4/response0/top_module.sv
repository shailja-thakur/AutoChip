module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);
	// Calculate Y2
	assign Y2 = y[1] & ~w;

	// Calculate Y4
	assign Y4 = y[2] & y[3] & y[5] & y[6] & w;

endmodule
