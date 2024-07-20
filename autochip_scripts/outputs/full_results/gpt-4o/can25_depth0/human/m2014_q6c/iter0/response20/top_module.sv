module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // One-hot encoding of states:
    // y[1] = A
    // y[2] = B
    // y[3] = C
    // y[4] = D
    // y[5] = E
    // y[6] = F

    // Deriving Y2 (next state B):
    // Y2 = (!w & y[1]) -> 0 input leads from A to B
    assign Y2 = (!w & y[1]);

    // Deriving Y4 (next state D):
    // Y4 = (w & y[2]) | (w & y[3]) | (w & y[4]) | (w & y[5]) | (w & y[6])
    assign Y4 = (w & y[2]) | (w & y[3]) | (w & y[4]) | (w & y[5]) | (w & y[6]);

endmodule
