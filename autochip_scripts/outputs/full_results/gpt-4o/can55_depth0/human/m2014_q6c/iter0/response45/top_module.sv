module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // Deriving next-state logic for Y2 and Y4 using one-hot encoding:
    // Y2 corresponds to state B 
    // Y4 corresponds to state D 

    assign Y2 = (y[1] & ~w) | (y[1] & w); // Transitions to B from A when w == 1 or w == 0 (both conditions)
    assign Y4 = (y[2] & w) | (y[3] & w) | (y[4] & w) | (y[6] & w) | (y[6] & ~w); // Transitions to D from B, C, D, E, F when w == 1 or F when w == 0

endmodule
