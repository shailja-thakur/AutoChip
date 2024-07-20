module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);
    // One-hot encoding of states
    // y[0] = A = 000001
    // y[1] = B = 000010
    // y[2] = C = 000100
    // y[3] = D = 001000
    // y[4] = E = 010000
    // y[5] = F = 100000

    // Deriving the signal Y1 (next state B)
    assign Y1 = y[0] & w;

    // Deriving the signal Y3 (next state D)
    assign Y3 = (y[1] & ~w) | (y[2] & ~w) | (y[3] & ~w) | (y[4] & ~w) | (y[5] & ~w);

endmodule
