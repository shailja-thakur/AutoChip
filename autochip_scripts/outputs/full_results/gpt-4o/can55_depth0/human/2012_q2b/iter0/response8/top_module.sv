module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // y[1] corresponds to state B
    // B --0--> D, B --1--> C
    assign Y1 = y[0] & w;

    // y[3] corresponds to state D
    // D --0--> A, D --1--> F
    assign Y3 = (y[1] & ~w) | (y[2] & ~w) | (y[5] & ~w);

endmodule
