module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // States encoding - one-hot encoding
    wire A = y[1];
    wire B = y[2];
    wire C = y[3];
    wire D = y[4];
    wire E = y[5];
    wire F = y[6];

    // Y2 (Next state B)
    // A (0) --0--> B
    // B (0) --0--> C
    // B (0) --1--> D
    assign Y2 = (A && !w);

    // Y4 (Next state D)
    // B (0) --1--> D
    // C (0) --1--> D
    // D (0) --1--> A
    // E (1) --1--> D
    // F (1) --1--> D
    assign Y4 = (B && w) || (C && w) || (D && w) || E || (F && w);

endmodule
