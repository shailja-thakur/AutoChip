module top_module (
    input [6:1] y,
    input w,
    output Y2,   // Corresponds to state B
    output Y4    // Corresponds to state D
);

    // Next state logic for Y2 (state B)
    // Y2 = y[1] & ~w  (A to B on w==0)
    assign Y2 = y[1] & ~w;

    // Next state logic for Y4 (state D)
    // Y4 = (y[2] & w) | (y[3] & w) | (y[4] & w) | (y[5] & ~w) | (y[6] & w)
    // B to D on w==1, C to D on w==1, D to D on w==1, F to D on w==1
    assign Y4 = (y[2] & w) | (y[3] & w) | (y[4] & w) | (y[5] & ~w) | (y[6] & w);

endmodule
