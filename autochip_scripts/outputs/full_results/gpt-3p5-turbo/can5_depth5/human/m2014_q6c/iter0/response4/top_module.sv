module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    assign Y2 = (y[1] & ~w) | (y[3] & w);   // next-state logic equation for Y2
    assign Y4 = (y[3] & ~w) | (y[5] & w);   // next-state logic equation for Y4

endmodule
