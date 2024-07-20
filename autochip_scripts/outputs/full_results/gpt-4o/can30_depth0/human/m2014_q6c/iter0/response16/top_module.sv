module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // State encoding:
    // y = 000001 for state A
    // y = 000010 for state B
    // y = 000100 for state C
    // y = 001000 for state D
    // y = 010000 for state E
    // y = 100000 for state F

    // Next-state logic for Y2 (state B):
    // B (y[2]) is set to 1 if previous state is A and input w is 0 (A --0--> B)
    // B (y[2]) is set to 1 if previous state is F and input w is 0 (F --0--> C)
    assign Y2 = (y[1] & ~w) | (y[6] & ~w);

    // Next-state logic for Y4 (state D):
    // D (y[4]) is set to 1 if previous state is B and input w is 1 (B --1--> D)
    // D (y[4]) is set to 1 if previous state is C and input w is 1 (C --1--> D)
    // D (y[4]) is set to 1 if previous state is F and input w is 1 (F --1--> D)
    assign Y4 = (y[2] & w) | (y[3] & w) | (y[6] & w);

endmodule
