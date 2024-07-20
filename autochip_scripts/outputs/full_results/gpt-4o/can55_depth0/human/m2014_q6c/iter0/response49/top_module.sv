module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // States encoding
    // y[1] : A (000001)
    // y[2] : B (000010)
    // y[3] : C (000100)
    // y[4] : D (001000)
    // y[5] : E (010000)
    // y[6] : F (100000)

    // Next state logic for state B (Y2) and state D (Y4)
    assign Y2 = (y[1] & ~w);   // From state A to state B when w == 0
    assign Y4 = (y[2] &  w)  | // From state B to state D when w == 1
                (y[3] &  w)  | // From state C to state D when w == 1
                (y[4] &  w)  | // From state D to state D when w == 1
                (y[5] &  w)  | // From state E to state D when w == 1
                (y[6] &  w);   // From state F to state D when w == 1

endmodule
