module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

// Derive the logic equations for Y2 and Y4 by inspection

// Y2 corresponds to the next-state signal for state y[2] (state B)
assign Y2 = (y[1] & ~w) | (y[3] & ~w) | (y[5] & w);

// Y4 corresponds to the next-state signal for state y[4] (state D)
assign Y4 = (y[2] & w) | (y[3] & w) | (y[6] & ~w);

endmodule
