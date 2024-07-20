module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

assign Y1 = ((y[0] & ~w) | (y[1] & w) | (y[5] & w)) & ~(y[2] | y[3] | y[4]);
assign Y3 = ((y[1] & ~w) | (y[2] & w) | (y[3] & ~w)) & ~(y[0] | y[4] | y[5]);

endmodule
