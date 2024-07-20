module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

// Logic for Y2 (next state for y[2])
assign Y2 = (y[1] & ~w) | (y[3] & ~w) | (y[5] & w);

// Logic for Y4 (next state for y[4])
assign Y4 = (y[2] & ~w) | (y[3] & w) | (y[6] & w);

endmodule
