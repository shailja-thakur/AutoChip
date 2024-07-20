module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

// Next-state logic for y[2]
assign Y2 = (y[1] & ~w) // A -> B
         | (y[2] & ~w) // B -> C
         | (y[3] & ~w) // C -> E
         | (y[4] & ~w) // D -> F
         | (y[5] & w)  // E -> D
         | (y[6] & ~w); // F -> C

// Next-state logic for y[4]
assign Y4 = (y[1] & w)   // A -> A
         | (y[2] & w)   // B -> D
         | (y[3] & w)   // C -> D
         | (y[4] & ~w)  // D -> A
         | (y[5] & w)   // E -> D
         | (y[6] & w);  // F -> D
endmodule
