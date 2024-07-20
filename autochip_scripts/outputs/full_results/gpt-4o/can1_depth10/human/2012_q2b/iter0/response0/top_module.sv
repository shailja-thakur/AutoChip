module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // One-hot state encoding
    // y[5:0] = 000001 -> A
    // y[5:0] = 000010 -> B
    // y[5:0] = 000100 -> C
    // y[5:0] = 001000 -> D
    // y[5:0] = 010000 -> E
    // y[5:0] = 100000 -> F

    // Logic for Y1 (input of state flip-flop y[1])
    // Y1 is high when the next state is B
    assign Y1 = y[0] & w;

    // Logic for Y3 (input of state flip-flop y[3])
    // Y3 is high when the next state is D
    assign Y3 = (y[1] & ~w) | (y[2] & ~w) | (y[3] & ~w) | (y[4] & ~w) | (y[5] & ~w);

endmodule
