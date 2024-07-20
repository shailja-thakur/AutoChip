module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    assign Y1 = (~y[0] & y[1]) | (y[0] & y[3]) | (y[2] & y[5]);
    assign Y3 = (~y[0] & y[3]) | (y[1] & y[2]) | (y[3] & ~w) | (y[4] & w) | (y[5] & y[2]);

endmodule
