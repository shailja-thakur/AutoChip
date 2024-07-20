module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

// Signal Y1 (input to state flip-flop y[1])
// Y1 = y[0] & ~w // Transition from A to B
    | y[1] & w    // Self-loop on B
    | y[3] & ~w   // Transition from D to A

assign Y1 = (y[0] & ~w) | (y[1] & w) | (y[3] & ~w);

// Signal Y3 (input to state flip-flop y[3]) 
// Y3 = y[1] & ~w // Transition from B to D
    | y[2] & ~w   // Transition from C to D
    | y[3] & w    // Transition from D to F
    | y[5] & ~w   // Transition from F to D

assign Y3 = (y[1] & ~w) | (y[2] & ~w) | (y[3] & w) | (y[5] & ~w);

endmodule
