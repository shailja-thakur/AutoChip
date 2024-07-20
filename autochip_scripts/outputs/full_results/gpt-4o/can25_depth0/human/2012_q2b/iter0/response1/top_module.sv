module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

    // State encoding based on the problem statement
    parameter A = 6'b000001, B = 6'b000010, C = 6'b000100,
              D = 6'b001000, E = 6'b010000, F = 6'b100000;

    // Deriving Y1 for state B (6'b000010)
    assign Y1 = (y == A && w == 1) || (y == F && w == 1);

    // Deriving Y3 for state D (6'b001000)
    assign Y3 = (y == B && w == 0) || (y == C && w == 0) || (y == D && w == 0) || (y == E && w == 0) || (y == F && w == 0);

endmodule
