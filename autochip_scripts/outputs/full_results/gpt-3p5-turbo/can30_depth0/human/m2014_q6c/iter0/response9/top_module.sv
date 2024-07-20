module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

	assign Y2 = (~y[6] & ~y[5] & y[4]);    // Y2 = not y[6] and not y[5] and y[4]
	assign Y4 = (~y[2] & y[1] & ~y[6]);    // Y4 = not y[2] and y[1] and not y[6]

endmodule
