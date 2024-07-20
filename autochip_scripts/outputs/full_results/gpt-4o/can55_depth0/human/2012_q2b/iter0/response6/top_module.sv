module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // Intermediate signals to indicate the current state
    wire state_A, state_B, state_C, state_D, state_E, state_F;

    assign state_A = y[0];
    assign state_B = y[1];
    assign state_C = y[2];
    assign state_D = y[3];
    assign state_E = y[4];
    assign state_F = y[5];

    // Compute Y1 (input of state flip-flop y[1] which represents state B)
    assign Y1 = (state_A & w);

    // Compute Y3 (input of state flip-flop y[3] which represents state D)
    assign Y3 = (state_B & ~w) | (state_C & ~w) | (state_D & ~w) | (state_E & ~w) | (state_F & ~w);

endmodule
