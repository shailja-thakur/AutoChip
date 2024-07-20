module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);
    // y[1] corresponds to state B
    // y[3] corresponds to state D

    assign Y1 = (y[0] & w);  // Transition from A to B
    assign Y3 = (y[1] & ~w) | (y[2] & ~w) | (y[3] & ~w) | (y[4] & ~w) | (y[5] & ~w);  // Transitions to state D from B, C, D, E, and F with input 0

endmodule
