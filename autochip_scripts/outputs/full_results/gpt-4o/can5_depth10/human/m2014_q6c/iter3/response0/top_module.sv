module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // State encoding
    // y[1] = A, y[2] = B, y[3] = C, y[4] = D, y[5] = E, y[6] = F

    // Next state logic for Y2 (B state)
    // B: A --0--> B (if w == 0 and y[1] == 1)
    // D: D --0--> B (if w == 0 and y[4] == 1)
    // F: F --1--> E (if w == 1 and y[6] == 1)
    assign Y2 = (y[1] & ~w) | (y[4] & ~w);

    // Next state logic for Y4 (D state)
    // B: B --1--> D (if w == 1 and y[2] == 1)
    // C: C --1--> D (if w == 1 and y[3] == 1)
    // E: E --1--> D (if w == 1 and y[5] == 1)
    // F: F --1--> D (if w == 1 and y[6] == 1)
    assign Y4 = (y[2] & w) | (y[3] & w) | (y[5] & w) | (y[6] & w);

endmodule
