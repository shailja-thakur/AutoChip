module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

// Derive the logic equations for Y2 and Y4 by inspection

// Y2 logic
assign Y2 = (y[1] & ~w) | // A -> B
           (y[2] & ~w) | // B -> C
           (y[4] & ~w) | // D -> F
           (y[5] & ~w); // E -> E

// Y4 logic
assign Y4 = (y[2] & w) | // B -> D
           (y[3] & ~w) | // C -> D
           (y[4] & w) | // D -> A
           (y[5] & w); // E -> D

endmodule
