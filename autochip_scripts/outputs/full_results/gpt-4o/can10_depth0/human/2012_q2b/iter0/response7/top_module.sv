module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    assign Y1 = (y[0] & w); // Transition from A to B when w is 1
    assign Y3 = (y[1] & ~w) | (y[2] & ~w) | (y[5] & ~w); // Transitions to D from B, C, F when w is 0

endmodule
