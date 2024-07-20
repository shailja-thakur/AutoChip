module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

// Next state logic
assign Y2 = y[6] & (~y[5] | ~y[1]);
assign Y4 = y[6] & (~y[5] | y[4]);

endmodule
