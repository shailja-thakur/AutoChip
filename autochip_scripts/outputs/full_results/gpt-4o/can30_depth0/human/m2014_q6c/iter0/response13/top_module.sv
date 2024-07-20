module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // Next-state logic for Y2 (state B)
    assign Y2 = (y[1] & ~w) | (y[4] & w); // Transition to state B from state A on w=0 or from state D on w=1

    // Next-state logic for Y4 (state D)
    assign Y4 = (y[2] & w) | (y[3] & w) | (y[5] & w) | (y[6] & w); // Transition to state D from states B, C, E, and F on w=1

endmodule
