module top_module (
    input [6:1] y,
    input w,
    output [2:1] Y2,
    output [4:1] Y4
);

    assign Y2 = (y[3] & !y[5]) | (y[1] & !y[3] & !y[5]) | (y[3] & y[5]);
    assign Y4 = (y[2] & !y[4]) | (y[2] & y[4]) | (y[4] & (w & y[3]));

endmodule
