module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);
    // States
    localparam 
        A = 6'b000001,
        B = 6'b000010,
        C = 6'b000100,
        D = 6'b001000,
        E = 6'b010000,
        F = 6'b100000;

    // Y2: Transition to state C (000100) or B (000010)
    assign Y2 = (y == A && w == 1'b0) || (y == B && w == 1'b0);

    // Y4: Transition to state D (001000)
    assign Y4 = (y == B && w == 1'b1) || (y == C && w == 1'b1) || 
                (y == D && w == 1'b0) || (y == E && w == 1'b1) ||
                (y == F && w == 1'b1);

endmodule
