module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

// Generate Y2 by taking the logical AND of the first bit of y and the logical NOT of w
assign Y2 = y[1] & ~w;

// Generate Y4 by taking the logical AND of the second, third, fifth and sixth bits of y and w
assign Y4 = y[2] & y[3] & y[5] & y[6] & w;

endmodule
