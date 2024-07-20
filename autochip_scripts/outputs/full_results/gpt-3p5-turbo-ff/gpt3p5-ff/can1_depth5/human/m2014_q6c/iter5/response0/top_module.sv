module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);
	// State A
	assign Y2 = (y[6] && w) ? 1'b1 : (y[1] && !w) ? 1'b1 : 1'b0;
	assign Y4 = (y[6] && !w) ? 1'b1 : (y[2] && !y[1] && w) ? 1'b1 : (y[3] && !y[1] && !w) ? 1'b1 : 1'b0;
endmodule
