module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);
	// State A
	assign Y2 = (y[6] && w) || (y[1] && !w);
	assign Y4 = y[2] || y[3] || y[4] || y[5];
endmodule
