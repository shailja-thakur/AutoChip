module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // State machine using one-hot encoding
    // y[6:1] encoding for states: A, B, C, D, E, F
    // y[6:1] = 000001, 000010, 000100, 001000, 010000, 100000

    // Next state logic for Y2 (state B)
    // Y2 is active in state B which transitions based on current states and input w
    assign Y2 = (y[1] & ~w) | // A --0--> B
                (y[4] & w);   // D --1--> A = w -> B

    // Next state logic for Y4 (state D)
    // Y4 is active in state D which transitions based on current states and input w
    assign Y4 = (y[2] & w) |  // B --1--> D
                (y[3] & w) |  // C --1--> D
                (y[4] & w) |  // D --1--> A = w -> D
                (y[5] & w) |  // E --1--> D
                (y[6] & w);   // F --1--> D

endmodule
