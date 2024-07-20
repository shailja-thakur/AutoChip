module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);
    // Derive Y2
    // Y2 is the state B
    // B -> y[2] in one-hot encoding
    // Next state logic for B (Y2):
    // If current state is A (y[1]==1) and input w is 0, Y2 = 1
    // If current state is D (y[4]==1) and input w is 0, Y2 = 1
    assign Y2 = (y[1] & ~w) | (y[4] & ~w);

    // Derive Y4
    // Y4 is the state D
    // D -> y[4] in one-hot encoding
    // Next state logic for D (Y4):
    // If current state is B (y[2]==1) and input w is 1, Y4 = 1
    // If current state is C (y[3]==1) and input w is 1, Y4 = 1
    // If current state is E (y[5]==1) and input w is 1, Y4 = 1
    // If current state is F (y[6]==1) and input w is 1, Y4 = 1
    assign Y4 = (y[2] & w) | (y[3] & w) | (y[5] & w) | (y[6] & w);

endmodule
