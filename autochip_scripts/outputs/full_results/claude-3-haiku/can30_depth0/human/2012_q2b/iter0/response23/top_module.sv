module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

// Y1 logic
assign Y1 = (~y[0] & y[1]) | (y[1] & ~y[2] & w) | (y[3] & ~y[4] & ~w) | (y[4] & ~y[5] & w) | (y[5] & ~y[1] & ~w);

// Y3 logic
assign Y3 = (y[1] & ~y[2] & ~w) | (y[2] & y[3] & w) | (y[3] & ~y[4] & ~w) | (y[5] & ~y[3] & w);

endmodule
