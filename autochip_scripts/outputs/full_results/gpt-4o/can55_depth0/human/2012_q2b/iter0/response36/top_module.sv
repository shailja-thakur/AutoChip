module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // State encoding:
    // y[5:0] = 000001(A), 000010(B), 000100(C), 001000(D), 010000(E), 100000(F)

    // Determine Y1, which is the input of state flip-flop y[1] (B state)
    assign Y1 = (y[0] & w) | (y[5] & w); // Transitions to B from states A with input 1, and F with input 1

    // Determine Y3, which is the input of state flip-flop y[3] (D state)
    assign Y3 = (y[1] & ~w) | (y[2] & ~w) | (y[4] & ~w) | (y[5] & ~w); // Transitions to D from states B, C, E, and F with input 0

endmodule
