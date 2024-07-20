module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

	wire y1 = y[1];
	wire y2 = y[2];
	wire y3 = y[3];
	wire y4 = y[4];
	wire y5 = y[5];
	wire y6 = y[6];

	assign Y2 = y1 & ~w;
	assign Y4 = y2 & y3 & y5 & y6 & w;

endmodule
