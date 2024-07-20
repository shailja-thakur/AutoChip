module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // State transition logic
    assign Y2 = y[1] & ~w | y[4] & ~y[6];
    assign Y4 = y[4] & (~y[5] | y[2]);

endmodule
