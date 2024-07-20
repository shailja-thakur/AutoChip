module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

	assign Y2 = y[3] | y[5] | (y[1] & w);  // Next state signal for y[2]
	assign Y4 = y[3] | y[4] | (y[5] & w);  // Next state signal for y[4]

endmodule
