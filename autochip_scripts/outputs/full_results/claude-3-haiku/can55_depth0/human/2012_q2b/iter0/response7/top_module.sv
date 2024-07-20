module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

// Signal Y1 logic
assign Y1 = (y[0] & ~w) | // A -> A
           (y[1] & w)   | // B -> C
           (y[3] & ~w);  // D -> A

// Signal Y3 logic
assign Y3 = (y[1] & ~w) | // B -> D
           (y[2] & w)   | // C -> E
           (y[3] & w)   | // D -> F
           (y[5] & ~w);  // F -> C
endmodule
