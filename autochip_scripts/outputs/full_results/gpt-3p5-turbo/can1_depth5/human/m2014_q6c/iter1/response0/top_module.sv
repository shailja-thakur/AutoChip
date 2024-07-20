module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

	// State signals
	wire A, B, C, D, E, F;
	assign A = (y == 6'b000001);
	assign B = (y == 6'b000010);
	assign C = (y == 6'b000100);
	assign D = (y == 6'b001000);
	assign E = (y == 6'b010000);
	assign F = (y == 6'b100000);

	// Next-state logic
	assign Y2 = (A && w) || (B && ~w) || (C && w) || (D && w) || (E && w) || (F && ~w);
	assign Y4 = (A && ~w) || (B && w) || (C && w) || (D && w) || (E && w) || (F && w);

endmodule
