module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // State definitions using one-hot encoding
    parameter A = 6'b000001;
    parameter B = 6'b000010;
    parameter C = 6'b000100;
    parameter D = 6'b001000;
    parameter E = 6'b010000;
    parameter F = 6'b100000;

    // Next state logic for Y1 (the input of state flip-flop y[1])
    assign Y1 = (y == A && w) || (y == D && !w);

    // Next state logic for Y3 (the input of state flip-flop y[3])
    assign Y3 = (y == B && !w) || (y == C && !w) || (y == F && !w);

endmodule
