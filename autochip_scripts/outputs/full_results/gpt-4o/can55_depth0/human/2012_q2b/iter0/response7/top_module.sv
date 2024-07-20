module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // State encoding:
    // A -> 000001
    // B -> 000010
    // C -> 000100
    // D -> 001000
    // E -> 010000
    // F -> 100000

    // Next state logic for Y1 (state B)
    // y[0] == 1 and w == 1 -> B  (A --1--> B)
    // y[5] == 1 and w == 1 -> C  (F --1--> C)
    assign Y1 = (y[0] && w) || (y[5] && w);

    // Next state logic for Y3 (state D)
    // y[1] == 1 and w == 0 -> D  (B --0--> D)
    // y[2] == 1 and w == 0 -> D  (C --0--> D)
    // y[3] == 1 and w == 0 -> A  (D --0--> A)
    // y[4] == 1 and w == 0 -> D  (E --0--> D)
    // y[5] == 1 and w == 0 -> D  (F --0--> D)
    assign Y3 = (y[1] && !w) || (y[2] && !w) || (y[3] && !w) || (y[4] && !w) || (y[5] && !w);

endmodule
