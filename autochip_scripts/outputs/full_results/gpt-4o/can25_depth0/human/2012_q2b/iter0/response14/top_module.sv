module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // Based on one-hot encoding and state transitions

    // y[1] corresponds to state B, which transitions to:
    // - state C (y[2]) if w = 1
    // - state D (y[3]) if w = 0
    assign Y1 = (y[0] & w);

    // y[3] corresponds to state D, which transitions to:
    // - state F (y[5]) if w = 1
    // - state A (y[0]) if w = 0
    assign Y3 = (y[1] & ~w) | (y[2] & ~w) | (y[5] & ~w);

endmodule
