module top_module (
    input [6:1] y,
    input w,
    output Y2, // Next-state signal for state B
    output Y4  // Next-state signal for state D
);

    // Deriving Y2 by inspection
    // Y2 (B) will be 1 if:
    // - Previous state is A (y[1]) and w is 0
    // - Previous state is E (y[5]) and w is 1

    assign Y2 = (y[1] & ~w) | (y[5] & w);

    // Deriving Y4 by inspection
    // Y4 (D) will be 1 if:
    // - Previous state is B (y[2]) and w is 1
    // - Previous state is C (y[3]) and w is 1
    // - Previous state is D (y[4]) and w is 1
    // - Previous state is F (y[6]) and w is 1

    assign Y4 = (y[2] & w) | (y[3] & w) | (y[4] & w) | (y[6] & w);

endmodule
