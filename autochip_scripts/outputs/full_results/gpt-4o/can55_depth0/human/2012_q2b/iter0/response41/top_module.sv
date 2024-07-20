module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // State assignment
    parameter A = 6'b000001;
    parameter B = 6'b000010;
    parameter C = 6'b000100;
    parameter D = 6'b001000;
    parameter E = 6'b010000;
    parameter F = 6'b100000;
    
    // Derive the signal Y1 (input of state flip-flop y[1])
    // y[1] corresponds to state B (6'b000010)
    assign Y1 = (y == A && w == 1) ? 1 : 0;
    
    // Derive the signal Y3 (input of state flip-flop y[3])
    // y[3] corresponds to state D (6'b001000)
    assign Y3 = (y == B && w == 0) ? 1 :
                (y == C && w == 0) ? 1 :
                (y == D && w == 0) ? 1 :
                (y == F && w == 0) ? 1 : 0;

endmodule
