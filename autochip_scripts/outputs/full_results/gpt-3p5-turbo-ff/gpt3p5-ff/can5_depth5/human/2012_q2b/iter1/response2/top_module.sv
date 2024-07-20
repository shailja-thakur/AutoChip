module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);
	
	// flip-flop Y1
	assign Y1 = (y[4] & ~w) | (y[1] & w); // Modified y[2] to y[1]
	
	// flip-flop Y3
	assign Y3 = (y[2] & ~w) | (y[1] & w); // Modified y[0] to y[1]

endmodule
