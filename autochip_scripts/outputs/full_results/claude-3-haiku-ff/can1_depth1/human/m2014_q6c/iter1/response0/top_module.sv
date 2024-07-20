module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

// Derive the logic equations for Y2 and Y4 by inspection using the one-hot encoding information

// Y2 (next-state signal for y[2])
assign Y2 = (y[1] & ~w) | (y[2] & ~w) | (y[4] & w);

// Y4 (next-state signal for y[4])
assign Y4 = (y[2] & w) | (y[4] & ~w) | (y[5] & w) | (y[6] & w);

endmodule
