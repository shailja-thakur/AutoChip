module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // State assignments using one-hot encoding
    // y[6:1] = 000001 -> A
    // y[6:1] = 000010 -> B
    // y[6:1] = 000100 -> C
    // y[6:1] = 001000 -> D
    // y[6:1] = 010000 -> E
    // y[6:1] = 100000 -> F

    // Y2 state corresponds to state B (000010)
    assign Y2 = (y[1] & ~w) | (y[6] & w);

    // Y4 state corresponds to state D (001000)
    assign Y4 = (y[2] & ~w) | (y[3] & w) | (y[4] & w) | (y[6] & w);

endmodule
