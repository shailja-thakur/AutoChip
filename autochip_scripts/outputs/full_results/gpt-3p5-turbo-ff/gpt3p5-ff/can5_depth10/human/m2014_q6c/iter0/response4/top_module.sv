module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    assign Y2 = y[3] | y[5] | (y[6] & w);
    assign Y4 = y[1] | y[3] | y[5];

endmodule
