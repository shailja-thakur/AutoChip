module top_module (
    input [6:1] y,
    input w,
    output wire Y2,
    output wire Y4
);

    assign Y2 = y[1] & ~w;
    assign Y4 = y[2] & y[3] & y[5] & y[6] & w;

endmodule
