module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    assign Y2 = ((y[2] & ~w & ~y[1]) | (y[0] & ~w & y[1]) | (y[4] & ~y[2] & y[3]));
    assign Y4 = ((y[4] & w & ~y[3]) | (y[2] & w & ~y[1]) | (y[3] & ~w & y[2]));

endmodule
