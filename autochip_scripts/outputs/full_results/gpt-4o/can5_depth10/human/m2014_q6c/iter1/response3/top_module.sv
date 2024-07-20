module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);
    // State encoding
    // y[1] = A, y[2] = B, y[3] = C, y[4] = D, y[5] = E, y[6] = F

    // Next state logic for Y2 (B state)
    // B: A --0--> B (if w == 0 AND y[1] == 1)
    // B: B --0--> C (if w == 0 AND y[2] == 1)
    assign Y2 = (y[1] & ~w) | (y[3] & ~w);

    // Next state logic for Y4 (D state)
    // D: B --1--> D (if w == 1 AND y[2] == 1)
    // D: C --1--> D (if w == 1 AND y[3] == 1)
    // D: D --1--> A (if w == 1 AND y[4] == 1)
    // D: E --1--> D (if w == 1 AND y[5] == 1)
    // D: F --1--> D (if w == 1 AND y[6] == 1)
    assign Y4 = (w & (y[2] | y[3] | y[5] | (y[1] & y[4] & y[6])));

endmodule
