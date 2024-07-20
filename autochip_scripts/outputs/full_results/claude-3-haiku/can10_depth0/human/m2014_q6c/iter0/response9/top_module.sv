module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

// Next-state signals for y[2] and y[4]

// Y2 (next state for y[2])
// y[2] = 1 when the state is B or D
assign Y2 = y[2] | y[4];

// Y4 (next state for y[4])
// y[4] = 1 when the state is C, E, or F
assign Y4 = y[3] | y[5] | y[6];

endmodule
