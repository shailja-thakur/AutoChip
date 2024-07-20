module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

	assign Y2 = (y[6] & y[4]) | (~y[6] & ~y[2]);
	assign Y4 = y[5] | y[3];

endmodule
