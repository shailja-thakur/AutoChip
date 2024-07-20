module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

// Next-state logic for y[2] (state B and D)
assign Y2 = (y[1] & ~w) | (y[4] & ~w);

// Next-state logic for y[4] (state C, D, and E)
assign Y4 = (y[3] & ~w) | (y[4] & w) | (y[5] & w);

endmodule
