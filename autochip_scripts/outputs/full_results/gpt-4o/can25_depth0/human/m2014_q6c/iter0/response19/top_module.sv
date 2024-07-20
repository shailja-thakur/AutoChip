module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // State encoding
    // A = 000001
    // B = 000010
    // C = 000100
    // D = 001000
    // E = 010000
    // F = 100000

    // Next-state signals
    // Y2 corresponds to state B (000010)
    // Y4 corresponds to state D (001000)

    assign Y2 = (y[1] & ~w) | (y[3] & ~w) | (y[6] & ~w);
    assign Y4 = (y[2] & w) | (y[3] & w) | (y[4] & w) | (y[5] & w) | (y[6] & w);

endmodule
