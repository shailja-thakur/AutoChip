module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

    // State encoding for one-hot
    parameter A = 6'b000001;
    parameter B = 6'b000010;
    parameter C = 6'b000100;
    parameter D = 6'b001000;
    parameter E = 6'b010000;
    parameter F = 6'b100000;
    
    // Next-state logic for Y2 (State B)
    assign Y2 = (y == A && w == 0) || (y == F && w == 0);

    // Next-state logic for Y4 (State D)
    assign Y4 = (y == B && w == 1) || (y == C && w == 1) || (y == D && w == 0) || (y == E && w == 1) || (y == F && w == 1);

endmodule
