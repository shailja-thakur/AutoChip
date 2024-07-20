module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

// Y2 next-state logic equation
assign Y2 = ~y[4] & ~y[3] & ~w | ~y[2] & y[1] & w | y[4] & y[3] & ~y[2] & ~y[1] & ~w;

// Y4 next-state logic equation
assign Y4 = y[4] & ~y[3] | ~y[4] & y[3] | y[2] & y[1];

endmodule
