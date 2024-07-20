module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

assign Y2 = (~y[1] & y[2] & ~w) | (y[1] & ~y[2] & w) | (y[4] & ~y[2] & w);
assign Y4 = (~y[2] & y[4] & ~w) | (y[2] & ~y[4] & w) | (y[6] & ~y[4] & w);

endmodule
