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
    // B: C --0--> E (if y[3] == 1) (initially missed transition to E as well)
    assign Y2 = (y[1] & ~w) | (y[3] & ~w); 

    // Next state logic for Y4 (D state)
    // D: B --1--> D (if w == 1 AND y[2] == 1)
    // D: C --1--> D (if w == 1 AND y[3] == 1)
    // D: D --0--> F (missed transition)
    // D: A --1--> A (if w == 1 AND y[1] == 1) (initially missed transition to A as well, fixed A to have proper next state)
    assign Y4 = (w & (y[2] | y[3])) | ((~w) & y[4]);

endmodule
