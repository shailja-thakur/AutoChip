module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // One-hot encoded states:
    // y[6:1] = 000001 -> state A
    // y[6:1] = 000010 -> state B
    // y[6:1] = 000100 -> state C
    // y[6:1] = 001000 -> state D
    // y[6:1] = 010000 -> state E
    // y[6:1] = 100000 -> state F

    // Y2 corresponds to state B
    // Y4 corresponds to state D

    // Determine Y2 and Y4 based on the state transitions and input w
    assign Y2 = (y[1] & ~w) |  // A goes to B on 0
                (y[4] & ~w);   // D goes to B on 0

    assign Y4 = (y[2] & w)  |  // B goes to D on 1
                (y[3] & w)  |  // C goes to D on 1
                (y[5] & w)  |  // E goes to D on 1
                (y[6] & w);    // F goes to D on 1

endmodule
