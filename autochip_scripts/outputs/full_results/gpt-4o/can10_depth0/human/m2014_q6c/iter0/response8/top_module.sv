module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);
    // Define state signals based on one-hot encoding
    wire A = y[1];
    wire B = y[2];
    wire C = y[3];
    wire D = y[4];
    wire E = y[5];
    wire F = y[6];

    // Derive the next-state logic for Y2 (state B)
    assign Y2 = (A & ~w) | (D & ~w);

    // Derive the next-state logic for Y4 (state D)
    assign Y4 = (B & w) | (C & w) | (E & w) | (F & w);

endmodule
