module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

// Deriving the expressions for Y1 and Y3 based on the one-hot state encoding and the state transition diagram

assign Y1 = (y[0] & ~w) | (y[1] & w) | (y[3] & w) | (y[5] & w);

assign Y3 = (y[1] & ~w) | (y[2] & w) | (y[3] & ~w) | (y[5] & ~w);

endmodule
