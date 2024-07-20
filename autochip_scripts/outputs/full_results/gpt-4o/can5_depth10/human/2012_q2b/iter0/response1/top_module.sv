module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // State encoding based on one-hot coding
    // A = 000001, B = 000010, C = 000100, D = 001000, E = 010000, F = 100000

    // Assign next state logic for Y1 (B state)
    assign Y1 = (y[0] & w);

    // Assign next state logic for Y3 (D state)
    assign Y3 = (y[1] & ~w) | (y[2] & ~w) | (y[4] & ~w) | (y[5] & ~w);

endmodule
