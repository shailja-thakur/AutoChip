module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // Signal Y1 (input of state flip-flop y[1])
    assign Y1 = (y[0] & w) |               // From state A to state B
                (y[2] & ~w) |              // From state C to state D
                (y[4] & ~w);               // From state E to state D

    // Signal Y3 (input of state flip-flop y[3])
    assign Y3 = (y[1] & ~w) |              // From state B to state D
                (y[2] & ~w) |              // From state C to state D
                (y[5] & ~w);               // From state F to state D

endmodule
