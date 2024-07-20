module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);  
    // State encoding (one-hot):
    // y[6:1] = 000001 -> State A
    // y[6:1] = 000010 -> State B
    // y[6:1] = 000100 -> State C
    // y[6:1] = 001000 -> State D
    // y[6:1] = 010000 -> State E
    // y[6:1] = 100000 -> State F

    assign Y2 = (y[1] & ~w)       // From state A to state B
              | (y[2] & ~w)       // From state B to state C
              | (y[3] & ~w);      // From state C to state E

    assign Y4 = (y[2] & w)        // From state B to state D
              | (y[3] & w)        // From state C to state D
              | (y[4] & w)        // From state D to state A
              | (y[5] & w)        // From state E to state D
              | (y[6] & w);       // From state F to state D

endmodule
