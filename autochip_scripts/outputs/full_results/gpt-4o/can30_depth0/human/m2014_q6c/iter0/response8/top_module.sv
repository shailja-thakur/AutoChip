module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // State Encoding:
    // A = 000001 -> y[6:1] = 000001
    // B = 000010 -> y[6:1] = 000010
    // C = 000100 -> y[6:1] = 000100
    // D = 001000 -> y[6:1] = 001000
    // E = 010000 -> y[6:1] = 010000
    // F = 100000 -> y[6:1] = 100000

    // Next state Y2 (B)
    // Y2 = (y[1] & ~w) | (y[4] & ~w)
    assign Y2 = (y[1] & ~w) | (y[4] & ~w);

    // Next state Y4 (D)
    // Y4 = (y[2] & w) | (y[3] & w) | (y[4] & w) | (y[5] & w) | (y[6] & w)
    assign Y4 = (y[2] & w) | (y[3] & w) | (y[4] & w) | (y[5] & w) | (y[6] & w);

endmodule
