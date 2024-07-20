module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // States encoding
    parameter A = 6'b000001;
    parameter B = 6'b000010;
    parameter C = 6'b000100;
    parameter D = 6'b001000;
    parameter E = 6'b010000;
    parameter F = 6'b100000;

    // Next-state logic for Y2 (state B)
    // A (0) --0--> B (Y2 is 1 if the next state is B)
    // B (0) --0--> C
    // B (0) --1--> D
    // Y2 will be 1 when we transition from state A to state B with w = 0
    assign Y2 = (y == A && w == 0);

    // Next-state logic for Y4 (state D)
    // B (0) --1--> D (Y4 is 1 if the next state is D)
    // C (0) --1--> D
    // D (0) --1--> A
    // E (1) --1--> D
    // F (1) --1--> D
    // Y4 will be 1 when we transition from B, C, E, or F to D with w = 1
    assign Y4 = (y == B && w == 1) ||
                (y == C && w == 1) ||
                (y == E && w == 1) ||
                (y == F && w == 1);

endmodule
