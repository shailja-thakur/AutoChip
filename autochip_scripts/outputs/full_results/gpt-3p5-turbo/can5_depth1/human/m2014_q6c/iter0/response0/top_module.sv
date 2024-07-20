module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // Next-state logic for Y2
    assign Y2 = y[1] | y[3] | y[5];
    
    // Next-state logic for Y4
    assign Y4 = y[2] & y[5];

endmodule
