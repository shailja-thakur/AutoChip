module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);
    // One-hot encoding states
    // A = 000001
    // B = 000010
    // C = 000100
    // D = 001000
    // E = 010000
    // F = 100000

    // Assign Y1
    // y[1] (state B) can be reached from state A if w is 1
    assign Y1 = y[0] & w; 

    // Assign Y3
    // y[3] (state D) can be reached from:
    // state B if w is 0
    // state C if w is 0
    // state D if w is 0
    // state E if w is 0
    // state F if w is 0
    assign Y3 = (y[1] & ~w) | (y[2] & ~w) | (y[3] & ~w) | (y[4] & ~w) | (y[5] & ~w);

endmodule
