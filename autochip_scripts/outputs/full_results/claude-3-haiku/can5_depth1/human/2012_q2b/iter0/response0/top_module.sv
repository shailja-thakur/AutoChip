module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // Derive the logic for Y1 (input of state flip-flop y[1])
    assign Y1 = (y[0] & w) | (y[1] & ~w) | (y[3] & w) | (y[5] & ~w);

    // Derive the logic for Y3 (input of state flip-flop y[3])
    assign Y3 = (y[1] & w) | (y[2] & ~w) | (y[3] & ~w) | (y[5] & w);

endmodule
