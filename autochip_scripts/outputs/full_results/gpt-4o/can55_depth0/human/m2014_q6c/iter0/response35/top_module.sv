module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // Assign the logic for Y2 and Y4 based on the state transitions and one-hot encoding
    assign Y2 = (~w & y[1]) | (~w & y[2]);
    assign Y4 = (w & y[2]) | (w & y[3]) | (w & y[6]);

endmodule
