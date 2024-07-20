module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // States encoding based on one-hot
    // State A: 000001, y[1] = 1
    // State B: 000010, y[2] = 1
    // State C: 000100, y[3] = 1
    // State D: 001000, y[4] = 1
    // State E: 010000, y[5] = 1
    // State F: 100000, y[6] = 1

    // Y2 corresponds to state B
    assign Y2 = (y[1] & ~w) | (y[2] & ~w) | (y[6] & ~w);

    // Y4 corresponds to state D
    assign Y4 = (y[2] & w) | (y[3] & w) | (y[5] & w) | (y[6] & w);

endmodule
