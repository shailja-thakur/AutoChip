module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // Define the state flip-flop inputs
    assign Y1 = (y[0] & w);             // Transition from state A to B
    assign Y3 = (y[1] & ~w) |           // Transition from state B to D
                (y[2] & ~w) |           // Transition from state C to D
                (y[3] & ~w) |           // Transition from state D to A
                (y[4] & ~w) |           // Transition from state E to D
                (y[5] & ~w);            // Transition from state F to D

endmodule
