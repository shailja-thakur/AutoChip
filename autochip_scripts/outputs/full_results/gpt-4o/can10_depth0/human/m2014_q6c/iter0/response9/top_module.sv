module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // y[1] = State A
    // y[2] = State B
    // y[3] = State C
    // y[4] = State D
    // y[5] = State E
    // y[6] = State F

    assign Y2 = (y[1] & ~w) | (y[6] & ~w); // State B from A (with w=0) or from F (with w=0)
    assign Y4 = (y[2] &  w) | (y[3] &  w) | (y[4] & ~w) | (y[5] &  w) | (y[6] &  w); // State D from B (with w=1), C (with w=1), D (with w=0), E (with w=1), or F (with w=1)

endmodule
