module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

// For Y1
assign Y1 = (y[0] & ~w) |   // A -> A
           (y[1] & ~w) |   // B -> D
           (y[3] & w)  |   // D -> F
           (y[4] & ~w);   // E -> D

// For Y3
assign Y3 = (y[1] & w)  |   // B -> C
           (y[2] & ~w) |   // C -> D
           (y[3] & ~w) |   // D -> A
           (y[5] & w);    // F -> C

endmodule
