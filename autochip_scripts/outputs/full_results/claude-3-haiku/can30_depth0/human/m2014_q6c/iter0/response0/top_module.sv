module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

// Next-state logic for y[2] (state B or D)
assign Y2 = (y[1] & ~w) | (y[4] & ~w);

// Next-state logic for y[4] (state C or E or F)
assign Y4 = (y[2] & ~w) | (y[5] & w) | (y[6] & w);

endmodule
