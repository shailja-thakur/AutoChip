module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // States encoded as one-hot
    // A = y[1], B = y[2], C = y[3], D = y[4], E = y[5], F = y[6]

    // Next state Y2 corresponds to state B:
    // B (000010) transitions:
    // B --0--> C (000100)
    // B --1--> D (001000)
    assign Y2 = y[1] & w;  // Transition to B happens from A with input 1

    // Next state Y4 corresponds to state D:
    // D (001000) transitions:
    // D --0--> F (100000)
    // D --1--> A (000001)
    assign Y4 = (y[2] & w) | (y[3] & w) | (y[4] & w) | (y[5] & w) | (y[6] & w);

endmodule
