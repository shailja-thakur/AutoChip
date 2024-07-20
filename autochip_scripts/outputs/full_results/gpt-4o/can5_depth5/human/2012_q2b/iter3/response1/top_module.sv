module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // One-hot encoded states
    parameter A = 6'b000001;
    parameter B = 6'b000010;
    parameter C = 6'b000100;
    parameter D = 6'b001000;
    parameter E = 6'b010000;
    parameter F = 6'b100000;

    // Y1 is the input to the flip-flop for state B (y[1]).
    // Transitions to state B occur from state A with w == 1
    assign Y1 = (y == A && w == 1) ? 1 : 0;

    // Y3 is the input to the flip-flop for state D (y[3]).
    // Transitions to state D occur from states B, C, E, and F with w == 0, 
    // or from state D itself with w == 0
    assign Y3 = ( (y == B && w == 0) || 
                  (y == C && w == 0) ||
                  (y == E && w == 0) ||
                  (y == F && w == 0) ||
                  (y == D && w == 0) ) ? 1 : 0;

endmodule
