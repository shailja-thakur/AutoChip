module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

	// State encoding (one-hot)
	parameter A = 6'b000001;
	parameter B = 6'b000010;
	parameter C = 6'b000100;
	parameter D = 6'b001000;
	parameter E = 6'b010000;
	parameter F = 6'b100000;

	// Next state logic for Y1 (state flip-flop y[1] represents state B)
	assign Y1 = (y == A && w) || (y == F && w);  // B can be reached from state A with w=1 or from state F with w=1
		
	// Next state logic for Y3 (state flip-flop y[3] represents state D)
	assign Y3 = (y == B && !w) || (y == C && !w) || (y == D && !w) || (y == E && !w) || (y == F && !w); // D can be reached from state B with w=0, state C with w=0, state D with w=0, state E with w=0, and state F with w=0

endmodule
