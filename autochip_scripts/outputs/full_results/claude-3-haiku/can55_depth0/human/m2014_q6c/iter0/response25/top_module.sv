module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

// Next-state logic for Y2 (corresponding to y[2])
assign Y2 = (y[1] & ~w) // A -> B
         | (y[2] & ~w) // B -> C
         | (y[4] & ~w) // D -> B
         | (y[6] & ~w); // F -> C

// Next-state logic for Y4 (corresponding to y[4])
assign Y4 = (y[2] & w)   // B -> D
         | (y[3] & ~w)  // C -> E
         | (y[4] & w)   // D -> A
         | (y[5] & ~w)  // E -> D
         | (y[6] & w);  // F -> D

endmodule
