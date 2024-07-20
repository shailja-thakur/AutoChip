module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);
    // State encodings
    // y = 000001 (A), 000010 (B), 000100 (C), 001000 (D), 010000 (E), 100000 (F)

    // Y1: next state will be B when current state is A and w is 1
    // and also next state will be D when current state is B and w is 0
    assign Y1 = (y[0] & w) | (y[1] & ~w);

    // Y3: next state will be D when current state is C and w is 0
    // and also next state will be D when current state is F and w is 0
    assign Y3 = (y[2] & ~w) | (y[5] & ~w);

endmodule
