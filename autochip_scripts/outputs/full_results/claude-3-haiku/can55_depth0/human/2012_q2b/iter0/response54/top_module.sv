module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

// Derive Y1 by inspection
assign Y1 = (y[0] & ~w) | (y[1] & w) | (y[3] & ~w) | (y[4] & ~w);

// Derive Y3 by inspection
assign Y3 = (y[1] & ~w) | (y[2] & w) | (y[3] & w) | (y[5] & w);

endmodule
