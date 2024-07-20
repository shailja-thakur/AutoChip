module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

// Y2 logic
assign Y2 = (y[1] & ~w) | // A -> B
           (y[2] & ~w) | // B -> C
           (y[4] & w); // E -> D

// Y4 logic
assign Y4 = (y[2] & w) | // B -> D
           (y[3] & ~w) | // C -> E
           (y[4] & ~w) | // E -> E
           (y[5] & ~w); // F -> C
endmodule
