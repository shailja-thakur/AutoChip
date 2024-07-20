module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // State encoding
    parameter A = 6'b000001;
    parameter B = 6'b000010;
    parameter C = 6'b000100;
    parameter D = 6'b001000;
    parameter E = 6'b010000;
    parameter F = 6'b100000;

    // Logic equations for Y2 and Y4
    assign Y2 = (~w & y[1]) | (~w & y[3]) | (w & y[6]);
    assign Y4 = (~w & y[2]) | (~w & y[1]) | (~w & y[4]) | (w & y[3]) | (w & y[6]) | (w & y[5]);

endmodule
