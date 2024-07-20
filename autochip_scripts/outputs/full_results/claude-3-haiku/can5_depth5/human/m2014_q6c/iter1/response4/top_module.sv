module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

// Next-state logic for y[2] (state B and state C)
assign Y2 = (y[2] & ~w) | (y[3] & ~w);

// Next-state logic for y[4] (state D and state E)
assign Y4 = (y[4] & w) | (y[5] & w) | (y[6] & ~w);

endmodule
