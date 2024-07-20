module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

	// States encoding
	parameter A = 6'b000001;
	parameter B = 6'b000010;
	parameter C = 6'b000100;
	parameter D = 6'b001000;
	parameter E = 6'b010000;
	parameter F = 6'b100000;

	assign Y2 = (y == A && ~w) || (y == E && ~w) || (y == F && ~w);
	assign Y4 = (y == B && w) || (y == C && w) || (y == D && ~w) || (y == E && w) || (y == F && w);

endmodule
