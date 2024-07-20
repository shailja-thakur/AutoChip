module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

	// State definitions based on one-hot encoding
	localparam A = 6'b000001;
	localparam B = 6'b000010;
	localparam C = 6'b000100;
	localparam D = 6'b001000;
	localparam E = 6'b010000;
	localparam F = 6'b100000;

	// Calculate Y1
	assign Y1 = (y == A && w) || (y == B && ~w);

	// Calculate Y3
	assign Y3 = (y == B && ~w) || (y == C && ~w) || (y == D && w) || (y == E && ~w) || (y == F && ~w);

endmodule
