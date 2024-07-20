module top_module (
    input [6:1] y, // one-hot state encoding
    input w,       // input w
    output Y2,     // next-state signal corresponding to state B
    output Y4      // next-state signal corresponding to state D
);

    // State encoding using one-hot
    wire state_A = y[1];
    wire state_B = y[2];
    wire state_C = y[3];
    wire state_D = y[4];
    wire state_E = y[5];
    wire state_F = y[6];

    // Derive the next-state logic for Y2 (corresponding to state B)
    assign Y2 = (state_A & ~w);

    // Derive the next-state logic for Y4 (corresponding to state D)
    assign Y4 = (state_B & w) | (state_C & w) | (state_D & w) | (state_E & w) | (state_F & w);

endmodule
