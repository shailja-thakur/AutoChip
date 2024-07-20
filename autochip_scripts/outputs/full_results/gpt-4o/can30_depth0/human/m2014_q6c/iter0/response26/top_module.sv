module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // One-hot encoding for the states
    // y[6:1] = 000001 (A)
    // y[6:1] = 000010 (B)
    // y[6:1] = 000100 (C)
    // y[6:1] = 001000 (D)
    // y[6:1] = 010000 (E)
    // y[6:1] = 100000 (F)

    // Next state equations for Y2 (state B)
    assign Y2 = (y[1] & ~w) // From state A to state B on w=0
               | (y[6] & w); // From state F to state B on w=1

    // Next state equations for Y4 (state D)
    assign Y4 = (y[2] & w) // From state B to state D on w=1
               | (y[3] & w) // From state C to state D on w=1
               | (y[4] & w) // From state D to state D on w=1
               | (y[5] & w) // From state E to state D on w=1
               | (y[6] & w); // From state F to state D on w=1

endmodule
