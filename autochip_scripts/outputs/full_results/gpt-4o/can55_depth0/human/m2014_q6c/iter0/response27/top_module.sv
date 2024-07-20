module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // States based on one-hot encoding
    parameter A = 6'b000001;
    parameter B = 6'b000010;
    parameter C = 6'b000100;
    parameter D = 6'b001000;
    parameter E = 6'b010000;
    parameter F = 6'b100000;

    // Next-state logic for Y2 (state B)
    assign Y2 = (y == A && !w) || (y == F && !w);

    // Next-state logic for Y4 (state D)
    assign Y4 = (y == B && w) || (y == C && w) || (y == D && w) || (y == E && w) || (y == F && w);

endmodule
