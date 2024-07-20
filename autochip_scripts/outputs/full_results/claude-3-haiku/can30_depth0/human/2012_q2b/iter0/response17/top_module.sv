module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

// Derive Y1 (input to state flip-flop y[1])
assign Y1 = (y[0] & w) | (y[1] & ~w) | (y[3] & w) | (y[5] & ~w);

// Derive Y3 (input to state flip-flop y[3])
assign Y3 = (y[1] & w) | (y[2] & ~w) | (y[3] & w) | (y[5] & ~w);

endmodule
