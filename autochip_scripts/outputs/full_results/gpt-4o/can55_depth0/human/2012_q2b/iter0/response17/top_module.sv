module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // y[0] = A, y[1] = B, y[2] = C, y[3] = D, y[4] = E, y[5] = F
    // Y1: input of state flip-flop y[1] (state B)
    // Y3: input of state flip-flop y[3] (state D)

    // Y1: B is next if (A and w = 1)
    assign Y1 = y[0] & w;

    // Y3: D is next if (B and w = 0) or (C and w = 0) or (D and w = 0) or (E and w = 0) or (F and w = 0)
    assign Y3 = (y[1] & ~w) | (y[2] & ~w) | (y[3] & ~w) | (y[4] & ~w) | (y[5] & ~w);

endmodule
