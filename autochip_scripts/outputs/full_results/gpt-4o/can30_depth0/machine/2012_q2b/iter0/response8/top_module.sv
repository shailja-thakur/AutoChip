module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // Compute Y1
    assign Y1 = y[0] & w;

    // Compute OR condition for Y3
    wire or_condition;
    assign or_condition = y[1] | y[2] | y[4] | y[5];

    // Compute Y3
    assign Y3 = or_condition & ~w;

endmodule
