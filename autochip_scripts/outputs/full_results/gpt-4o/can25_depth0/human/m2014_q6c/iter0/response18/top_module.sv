module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // State encoding
    parameter A = 6'b000001;
    parameter B = 6'b000010;
    parameter C = 6'b000100;
    parameter D = 6'b001000;
    parameter E = 6'b010000;
    parameter F = 6'b100000;

    // Next-state logic for Y2 (state B)
    assign Y2 = (y == A && w == 1'b0) || (y == D && w == 1'b0);

    // Next-state logic for Y4 (state D)
    assign Y4 = (y == B && w == 1'b1) || (y == C && w == 1'b1) || (y == D && w == 1'b0) || (y == E && w == 1'b1) || (y == F && w == 1'b1);

endmodule
