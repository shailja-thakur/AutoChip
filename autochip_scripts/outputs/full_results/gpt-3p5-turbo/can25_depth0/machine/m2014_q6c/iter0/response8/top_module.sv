module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);
	// Defining intermediate signals
	wire y1, y2, y3, y4, y5, y6;

	// Splitting y into individual bits
	assign y1 = y[1];
	assign y2 = y[2];
	assign y3 = y[3];
	assign y4 = y[4];
	assign y5 = y[5];
	assign y6 = y[6];

	// Generating Y2 using logical AND operations
	assign Y2 = y1 & ~w;

	// Generating Y4 using logical AND operations
	assign Y4 = y2 & y3 & y5 & y6 & w;
endmodule
