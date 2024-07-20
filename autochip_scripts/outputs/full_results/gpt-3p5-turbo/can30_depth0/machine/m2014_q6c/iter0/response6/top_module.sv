module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    wire y1;
    wire y2;
    wire y3;
    wire y4;
    wire y5;
    wire y6;

    assign y1 = y[1];
    assign y2 = y[2];
    assign y3 = y[3];
    assign y4 = y[4];
    assign y5 = y[5];
    assign y6 = y[6];

    assign Y2 = y1 & ~w;
    assign Y4 = y2 & y3 & y5 & y6 & w;

endmodule
