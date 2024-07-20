module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

// Y1 is the input of state flip-flop y[1]
assign Y1 = (y[0] & ~w) | // A to A
           (y[1] & w)   | // B to C
           (y[3] & w);   // D to F

// Y3 is the input of state flip-flop y[3]
assign Y3 = (y[0] & ~w) | // A to A
           (y[1] & ~w) | // B to D
           (y[2] & ~w) | // C to D
           (y[3] & ~w) | // D to A
           (y[4] & ~w); // E to D

endmodule
