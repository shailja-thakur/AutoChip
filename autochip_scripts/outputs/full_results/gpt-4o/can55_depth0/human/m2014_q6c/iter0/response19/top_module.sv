module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // States: A=000001, B=000010, C=000100, D=001000, E=010000, F=100000
    // y[6:1] = 000001 for state A
    // y[6:1] = 000010 for state B
    // y[6:1] = 000100 for state C
    // y[6:1] = 001000 for state D
    // y[6:1] = 010000 for state E
    // y[6:1] = 100000 for state F

    // Derive the next state Y2 and Y4 based on the transitions
    assign Y2 = (y[1] & w) | (y[4] & ~w); // Next state B
    assign Y4 = (y[2] & w) | (y[3] & w) | (y[5] & ~w) | (y[6] & w); // Next state D

endmodule
