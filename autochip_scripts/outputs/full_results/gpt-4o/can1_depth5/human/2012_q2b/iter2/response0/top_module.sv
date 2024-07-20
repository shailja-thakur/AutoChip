module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // The next state logic for Y1 (state B): Only active from state A when w is 1
    assign Y1 = y[0] & w;

    // The next state logic for Y3 (state D): Can be reached from B, C, D, E, or F when w is 0
    assign Y3 = (y[1] & ~w) | (y[2] & ~w) | (y[3] & ~w) | (y[4] & ~w) | (y[5] & w);

endmodule
