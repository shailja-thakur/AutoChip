module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    wire y1 = y[1];
    wire y2 = w;
    wire y3 = y[6];
    wire y4 = y[5];
    wire y5 = y[3];
    wire y6 = y[2];
    
    assign Y2 = y1 & ~y2;
    assign Y4 = y3 & y4 & y5 & y6 & w;

endmodule
