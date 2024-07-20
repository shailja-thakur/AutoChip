module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    assign Y1 = (y[0] & w) | (y[1] & ~w) | (y[2] & ~w) | (y[3] & ~w); // Y1 transitions to state B
    assign Y3 = (y[1] & ~w) | (y[2] & ~w) | (y[3] & w) | (y[4] & ~w) | (y[5] & ~w); // Y3 transitions to state D

endmodule
