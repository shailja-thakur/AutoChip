module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

// Deriving the logic equations for Y2 and Y4

// For Y2 (state y[2]):
// Y2 = (y[1] & ~w) // B -> C
//    | (y[3] & ~w) // C -> E
//    | (y[4] & w)  // D -> A

assign Y2 = (y[1] & ~w) | (y[3] & ~w) | (y[4] & w);

// For Y4 (state y[4]):
// Y4 = (y[1] & w)   // B -> D
//    | (y[3] & w)   // C -> D
//    | (y[4] & ~w)  // D -> F
//    | (y[5] & w)   // E -> D
//    | (y[6] & w)   // F -> D

assign Y4 = (y[1] & w) | (y[3] & w) | (y[4] & ~w) | (y[5] & w) | (y[6] & w);

endmodule
