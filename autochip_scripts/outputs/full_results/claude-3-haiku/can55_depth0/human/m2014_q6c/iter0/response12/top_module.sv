module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

// Derive the logic equations for Y2 and Y4 by inspection
// using the one-hot state encoding information provided

// Y2 (next-state for y[2])
assign Y2 = (y[1] & ~w) |   // A -> B
           (y[2] & ~w) |   // B -> C
           (y[4] & ~w) |   // D -> F
           (y[5] & w);    // E -> D

// Y4 (next-state for y[4])
assign Y4 = (y[2] & w) |   // B -> D
           (y[3] & ~w) |   // C -> E
           (y[4] & w) |    // D -> A
           (y[5] & ~w);   // E -> E

endmodule
