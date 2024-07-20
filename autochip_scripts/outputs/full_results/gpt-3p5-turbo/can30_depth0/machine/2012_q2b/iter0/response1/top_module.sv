module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // Declaration of signals
    wire w_not;
    wire [3:0] y_or;

    // Y1 is the logical AND of the first bit of the input vector y and the single bit input w
    assign Y1 = y[0] & w;

    // w_not is the logical NOT of the single bit input w
    assign w_not = ~w;

    // y_or is the logical OR of the second, third, fifth and sixth bits of the input vector y
    assign y_or = y[1] | y[2] | y[4] | y[5];

    // Y3 is the logical AND of y_or and w_not
    assign Y3 = y_or & w_not;

endmodule
