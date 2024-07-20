module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

	assign Y2 = y[6] & !y[5] & !y[4] & !y[3];
	assign Y4 = y[2] & !y[1] & !y[0] & (y[6] | y[5] | y[4] | y[3] | y[2] | y[1]);

endmodule
