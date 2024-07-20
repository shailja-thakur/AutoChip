module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // State encoding (one-hot)
    // y[1] - State A (000001)
    // y[2] - State B (000010)
    // y[3] - State C (000100)
    // y[4] - State D (001000)
    // y[5] - State E (010000)
    // y[6] - State F (100000)

    // Next state logic for Y2 (corresponds to state B)
    assign Y2 = (y[1] & ~w);

    // Next state logic for Y4 (corresponds to state D)
    assign Y4 = (y[2] & w) |
                (y[3] & w) |
                (y[6] & w) |
                (y[5] & w);

endmodule
