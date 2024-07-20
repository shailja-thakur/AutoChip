module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // Define one-hot state bits
    wire A = y[1];
    wire B = y[2];
    wire C = y[3];
    wire D = y[4];
    wire E = y[5];
    wire F = y[6];

    // Next-state logic for Y2 (representing state B)
    assign Y2 = (A & ~w) | (C & ~w);

    // Next-state logic for Y4 (representing state D)
    assign Y4 = (B & w) | (C & w) | (D & w) | (E & w) | (F & w);

endmodule
