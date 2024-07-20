module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

// Deriving the logic equations for Y2 and Y4 by inspection:

// Y2 (next state for y[2])
// From the state diagram, y[2] is 1 in state B and D
// y[2] becomes 1 when y[1] is 1 (state B) or y[4] is 1 (state D), and w is 0
assign Y2 = (y[1] & ~w) | (y[4] & ~w);

// Y4 (next state for y[4])
// From the state diagram, y[4] is 1 in state C, D, and E
// y[4] becomes 1 when y[3] is 1 (state C), y[4] is 1 (state D), or y[5] is 1 (state E), and w is 0
assign Y4 = (y[3] & ~w) | (y[4] & ~w) | (y[5] & ~w);

endmodule
