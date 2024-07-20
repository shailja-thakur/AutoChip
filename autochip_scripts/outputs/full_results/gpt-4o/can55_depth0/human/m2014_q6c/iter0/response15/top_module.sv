module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // Decode y to determine current state
    wire A, B, C, D, E, F;
    assign A = y[1];
    assign B = y[2];
    assign C = y[3];
    assign D = y[4];
    assign E = y[5];
    assign F = y[6];

    // Derive logic equations for Y2 and Y4
    assign Y2 = (A & ~w) | (F & ~w);
    assign Y4 = (B & w) | (C & w) | (D & w);

endmodule
