module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    assign Y2 = (y[1] & ~w)   // A to B
              | (y[3] & ~w)   // B to C
              | (y[6] & ~w);  // F to C

    assign Y4 = (y[3] & w)    // B to D
              | (y[5] & w)    // C to D
              | (y[6] & w);   // F to D

endmodule
