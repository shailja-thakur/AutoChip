module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    wire Y2_logic; // internal wire for Y2
    wire Y4_logic; // internal wire for Y4

    assign Y2_logic = ~(y[1] & w); // Y2 is the logical AND of the first bit of y and the logical NOT of w
    assign Y4_logic = y[2] & y[3] & y[5] & y[6] & w; // Y4 is the logical AND of the second, third, fifth and sixth bits of y and w

    assign Y2 = Y2_logic; // assign Y2 output
    assign Y4 = Y4_logic; // assign Y4 output

endmodule
