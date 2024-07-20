module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // State encodings
    wire A = y[1];
    wire B = y[2];
    wire C = y[3];
    wire D = y[4];
    wire E = y[5];
    wire F = y[6];

    // Derive logic for next-state signals
    assign Y2 = (A & ~w) | (B & ~w) | (F & ~w);
    assign Y4 = (B & w) | (C & w) | (F & w) | (D & w);

endmodule
