module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // Assign the output signals based on the state transitions
    assign Y1 = y[0] & w;             // Transition from state A to state B
    assign Y3 = (y[1] & ~w) |         // Transition from state B to state D
                (y[2] & ~w) |         // Transition from state C to state D
                (y[5] & ~w);          // Transition from state F to state D

endmodule
