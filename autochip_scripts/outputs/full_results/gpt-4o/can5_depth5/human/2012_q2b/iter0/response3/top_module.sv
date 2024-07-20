module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // State encoding
    parameter A = 6'b000001;
    parameter B = 6'b000010;
    parameter C = 6'b000100;
    parameter D = 6'b001000;
    parameter E = 6'b010000;
    parameter F = 6'b100000;
    
    // Derive Y1 (input to state flip-flop y[1])
    assign Y1 = (y == A && w == 1) ? 1 :  // Transition from A to B
                (y == C && w == 1) ? 1 :  // Transition from C to E
                0;
    
    // Derive Y3 (input to state flip-flop y[3])
    assign Y3 = (y == B && w == 0) ? 1 :  // Transition from B to D
                (y == C && w == 0) ? 1 :  // Transition from C to D
                (y == D && w == 0) ? 1 :  // Transition from D to A
                (y == E && w == 0) ? 1 :  // Transition from E to D
                (y == F && w == 0) ? 1 :  // Transition from F to D
                0;

endmodule
