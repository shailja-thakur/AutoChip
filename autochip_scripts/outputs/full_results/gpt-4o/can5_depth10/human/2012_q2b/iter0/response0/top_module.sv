module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

	// State encoding
	localparam A = 6'b000001;
	localparam B = 6'b000010;
	localparam C = 6'b000100;
	localparam D = 6'b001000;
	localparam E = 6'b010000;
	localparam F = 6'b100000;

	// Y1 is the next state flip-flop input for state B
	assign Y1 = (y == A && w == 1) || (y == B && w == 0);

	// Y3 is the next state flip-flop input for state D
	assign Y3 = (y == B && w == 0) || (y == C && w == 0) || (y == D && w == 0) || (y == E && w == 0) || (y == F && w == 0);

endmodule
