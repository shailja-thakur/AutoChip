module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // Assign signal Y1 based on the current state and input w
    assign Y1 = (y[0] & w); // Transition from state A to B
                           //(000001)

    // Assign signal Y3 based on the current state and input w
    //(000010)
    // The transitions to state D are from states B(000010), C(000100), F(100000), and E(010000) when w=0
    // Transition from state B to D if w == 0 -> 000010 & ~w
    // Transition from state C to D if w == 0 -> 000100 & ~w
    // Transition from state F to D if w == 0 -> 100000 & ~w
    // Transition from state E to D if w == 0 -> 010000 & ~w
    assign Y3 = (y[1] & ~w) | (y[2] & ~w) | (y[5] & ~w) | (y[4] & ~w);

endmodule
