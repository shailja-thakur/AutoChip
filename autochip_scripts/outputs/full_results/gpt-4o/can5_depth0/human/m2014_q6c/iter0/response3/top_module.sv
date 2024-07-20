module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // State assignment using one-hot encoding
    // A: 000001
    // B: 000010
    // C: 000100
    // D: 001000
    // E: 010000
    // F: 100000

    assign Y2 = (y[1] & ~w) |  // From A to B
                (y[4] & w);    // From D to A or D to B

    assign Y4 = (y[2] & w)   |  // From B to D
                (y[3] & w);    // From C to D or From F to D
endmodule
