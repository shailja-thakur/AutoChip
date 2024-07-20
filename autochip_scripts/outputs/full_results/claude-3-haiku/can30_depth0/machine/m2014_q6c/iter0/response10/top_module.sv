module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // Y2 = y[1] AND (NOT w)
    assign Y2 = y[1] & ~w;

    // Y4 = y[2] AND y[3] AND y[5] AND y[6] AND w
    assign Y4 = y[2] & y[3] & y[5] & y[6] & w;

endmodule
