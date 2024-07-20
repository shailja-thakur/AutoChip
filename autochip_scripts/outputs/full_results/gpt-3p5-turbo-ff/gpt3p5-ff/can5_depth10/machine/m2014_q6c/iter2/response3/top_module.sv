module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);
	assign Y2 = y[0] & ~w;
	assign Y4 = y[3] & y[2] & y[1] & y[0] & w;
endmodule
