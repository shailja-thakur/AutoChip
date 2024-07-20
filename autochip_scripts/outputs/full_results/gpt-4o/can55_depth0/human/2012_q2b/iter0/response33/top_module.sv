module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);
    // state assignments
    parameter A = 6'b000001;
    parameter B = 6'b000010;
    parameter C = 6'b000100;
    parameter D = 6'b001000;
    parameter E = 6'b010000;
    parameter F = 6'b100000;

    // Deriving Y1: y[1] refers to state B
    // B (0) --1--> C
    // A (0) --1--> B
    // Y1 should be 1 if we transition to state B (when y == A and w == 1)
    assign Y1 = (y == A) & w;

    // Deriving Y3: y[3] refers to state D
    // B (0) --0--> D
    // C (0) --0--> D
    // D (0) --0--> A
    // E (1) --0--> D
    // F (1) --0--> D
    // Y3 should be 1 if we transition to state D (when y == B and w == 0) or (when y == C and w == 0) or (when y == D and w == 0) or (when y == E and w == 0) or (when y == F and w == 0)
    assign Y3 = ((y == B) & ~w) | ((y == C) & ~w) | ((y == D) & ~w) | ((y == E) & ~w) | ((y == F) & ~w);

endmodule
