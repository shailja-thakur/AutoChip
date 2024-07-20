module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);
    // One-hot state machine
    // y[5:0] state encoding: 
    // 000001 - A
    // 000010 - B
    // 000100 - C
    // 001000 - D
    // 010000 - E
    // 100000 - F

    // Y1 is the input for state flip-flop y[1], referring to state B
    assign Y1 = (y[0] & w);  // From state A to state B on w=1

    // Y3 is the input for state flip-flop y[3], referring to state D
    assign Y3 = (y[1] & ~w) | (y[2] & ~w) | (y[3] & ~w) | (y[5] & ~w);
    // Transitions:
    // From B to D on w=0
    // From C to D on w=0
    // From D to D on w=0
    // From F to D on w=0

endmodule
