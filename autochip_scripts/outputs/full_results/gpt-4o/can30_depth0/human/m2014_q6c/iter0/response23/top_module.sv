module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // One-hot encoding for states
    // y[6:1] = 000001 for state A
    // y[6:1] = 000010 for state B
    // y[6:1] = 000100 for state C
    // y[6:1] = 001000 for state D
    // y[6:1] = 010000 for state E
    // y[6:1] = 100000 for state F 

    // Determine Y2 and Y4 from the state transitions

    // Y2 corresponds to state B (000010) transition
    assign Y2 = (y[1] & ~w) | (y[4] & ~w) | (y[6] & ~w);

    // Y4 corresponds to state D (001000) transition
    assign Y4 = (y[2] & w) | (y[3] & w) | (y[1] & w) | (y[5] & w);

endmodule
