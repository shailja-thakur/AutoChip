module top_module(
	input x,
	input y,
	output z);

	// Intermediate signal declarations
	wire wx, wy, wnotx, wnoty, wor, wnotor;

	// Assign signals
	assign wx = x;
	assign wy = y;
	assign wnotx = ~x;
	assign wnoty = ~y;
	assign wor = wx | wy;
	assign wnotor = ~wor;
	assign z = wnotor;

endmodule
