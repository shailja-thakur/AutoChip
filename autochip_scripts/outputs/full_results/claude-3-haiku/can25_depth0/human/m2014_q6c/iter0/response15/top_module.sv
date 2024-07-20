module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

// Next-state logic for Y2 (corresponding to y[2])
assign Y2 = (y[1] & ~w) | (y[2] & w) | (y[3] & ~w) | (y[5] & ~w);

// Next-state logic for Y4 (corresponding to y[4])
assign Y4 = (y[2] & ~w) | (y[3] & w) | (y[4] & w) | (y[6] & w);

endmodule
