module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);
	// Create intermediate signals to represent individual bits of y
	reg y0, y1, y2, y3, y4, y5, y6;

	// Assign values to individual bits of y
	assign y0 = y[1];
	assign y1 = y[2];
	assign y2 = y[3];
	assign y3 = y[4];
	assign y4 = y[5];
	assign y5 = y[6];
	assign y6 = 0; // Default value for y6 since it's not used in Y2 calculation

	// Calculate Y2
	assign Y2 = y0 & ~w;

	// Calculate Y4
	assign Y4 = y1 & y2 & y4 & y5 & w;

endmodule
