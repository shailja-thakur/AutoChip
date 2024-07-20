module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // y[1]: A, y[2]: B, y[3]: C, y[4]: D, y[5]: E, y[6]: F

    // Derive Y2 (next state B)
    // y[1] --0--> y[2] (A to B)
    assign Y2 = y[1] & ~w;

    // Derive Y4 (next state D)
    // y[2] --1--> y[4] (B to D)
    // y[3] --1--> y[4] (C to D)
    // y[5] --1--> y[4] (E to D)
    // y[6] --1--> y[4] (F to D)
    assign Y4 = (y[2] & w) | (y[3] & w) | (y[5] & w) | (y[6] & w);

endmodule
