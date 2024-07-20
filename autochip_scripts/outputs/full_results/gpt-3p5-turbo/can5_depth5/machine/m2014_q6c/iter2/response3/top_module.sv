module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);
    wire [3:0] y_sub;

    assign Y2 = y[1] & ~w;
    assign y_sub = {y[6], y[5], y[3], y[2]};
    assign Y4 = y_sub[3] & y_sub[2] & y_sub[1] & y_sub[0] & w;
endmodule
