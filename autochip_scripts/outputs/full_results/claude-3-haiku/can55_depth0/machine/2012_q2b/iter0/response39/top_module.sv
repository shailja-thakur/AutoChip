module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // Implement the logic for Y1
    assign Y1 = y[0] & w;

    // Implement the logic for Y3
    wire y_or = y[1] | y[2] | y[4] | y[5];
    assign Y3 = y_or & ~w;

endmodule
