module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // State Encoding
    // A - 000001
    // B - 000010
    // C - 000100
    // D - 001000
    // E - 010000
    // F - 100000

    // Derive Y2 (next state B - 000010)
    assign Y2 = y[1] & ~w; // Transition from A to B when w is 0
    // Derive Y4 (next state D - 001000)
    assign Y4 = (y[2] & w) | // Transition from B to D when w is 1
                (y[3] & w) | // Transition from C to D when w is 1
                (y[4] & ~w) | // Transition from D to F when w is 0
                (y[5] & w) | // Transition from E to D when w is 1
                (y[6] & w);   // Transition from F to D when w is 1
endmodule
