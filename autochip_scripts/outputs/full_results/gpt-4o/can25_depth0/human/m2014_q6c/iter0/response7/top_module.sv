module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // One-hot encoding of states:
    // y[6:1] = 000001 -> A
    // y[6:1] = 000010 -> B
    // y[6:1] = 000100 -> C
    // y[6:1] = 001000 -> D
    // y[6:1] = 010000 -> E
    // y[6:1] = 100000 -> F

    // The next-state logic for each output
    assign Y2 = (y[1] & ~w) | (y[6] & ~w); // Transition to state B (y[2]) from A (y[1] & ~w) or F (y[6] & ~w)
    
    assign Y4 = (y[2] & w)                // Transition to state D (y[4]) from B (y[2] & w)
              | (y[3] & w)                // Transition to state D (y[4]) from C (y[3] & w)
              | (y[4] & w)                // Transition to state D (y[4]) from D (y[4] & w)
              | (y[5] & w)                // Transition to state D (y[4]) from E (y[5] & w)
              | (y[6] & w);               // Transition to state D (y[4]) from F (y[6] & w)

endmodule
