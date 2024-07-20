module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // Y2 corresponds to state B (000010) and state D (001000)
    assign Y2 = (y[1] & ~w) | (y[2] & ~w) | (y[3] & w) | (y[5] & w);

    // Y4 corresponds to state D (001000)
    assign Y4 = (y[2] & w) | (y[3] & w) | (y[4] & w) | (y[6] & ~w);
endmodule
