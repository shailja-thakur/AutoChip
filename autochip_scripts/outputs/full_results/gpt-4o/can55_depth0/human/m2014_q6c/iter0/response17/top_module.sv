module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // State Encoding:
    // A = 6'b000001
    // B = 6'b000010
    // C = 6'b000100
    // D = 6'b001000
    // E = 6'b010000
    // F = 6'b100000

    // Next State Logic for Y2 (State B):
    // Y2 will be high when:
    // - Current state is A and input w is 0.
    assign Y2 = (y[1] & ~w);

    // Next State Logic for Y4 (State D):
    // Y4 will be high when:
    // - Current state is B and input w is 1.
    // - Current state is C and input w is 1.
    // - Current state is D and input w is 1.
    // - Current state is E and input w is 1.
    // - Current state is F and input w is 1.
    assign Y4 = (y[2] & w) | (y[3] & w) | (y[4] & w) | (y[5] & w) | (y[6] & w);

endmodule
