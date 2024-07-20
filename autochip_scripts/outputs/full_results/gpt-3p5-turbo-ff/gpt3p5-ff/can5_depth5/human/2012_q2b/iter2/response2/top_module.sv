module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);
	
	// flip-flop Y1
	assign Y1 = (y[4] & ~w) | (y[0] & w); // Modified y[1] to y[0]
	
	// flip-flop Y3
	assign Y3 = (y[2] & ~w) | (y[0] & w); // Modified y[1] to y[0]

endmodule
