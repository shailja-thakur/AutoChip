module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    wire Y2;
    wire Y4;

    assign Y2 = y[6] | y[5] & ~y[4] | w & y[2] & ~y[1];
    assign Y4 = y[2] & ~y[1] | w & y[4] & ~y[3] | w & y[2] & ~y[1];

endmodule
