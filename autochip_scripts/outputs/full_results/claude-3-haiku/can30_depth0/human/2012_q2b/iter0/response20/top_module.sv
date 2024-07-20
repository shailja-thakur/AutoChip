module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

// Y1 is the input to the state flip-flop y[1]
assign Y1 = (y[0] & ~w) | // A -> A
           (y[1] & w) |   // B -> C
           (y[3] & w) |   // D -> F
           (y[4] & ~w);   // E -> D

// Y3 is the input to the state flip-flop y[3]
assign Y3 = (y[1] & ~w) |  // B -> D
           (y[2] & w) |    // C -> E
           (y[3] & ~w) |   // D -> A
           (y[5] & ~w);    // F -> C

endmodule
