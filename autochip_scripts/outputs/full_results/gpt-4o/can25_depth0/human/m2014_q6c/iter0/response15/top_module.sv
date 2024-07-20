module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // One-hot encoded states
    parameter A = 6'b000001;
    parameter B = 6'b000010;
    parameter C = 6'b000100;
    parameter D = 6'b001000;
    parameter E = 6'b010000;
    parameter F = 6'b100000;

    // Next-state logic for Y2 (corresponding to state C)
    assign Y2 = (y == B && ~w) || (y == F && ~w);

    // Next-state logic for Y4 (corresponding to state E)
    assign Y4 = (y == C && ~w) || (y == E && ~w);

endmodule
