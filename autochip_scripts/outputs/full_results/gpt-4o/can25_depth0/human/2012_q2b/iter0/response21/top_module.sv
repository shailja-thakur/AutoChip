module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // State Encoding
    parameter A = 6'b000001;
    parameter B = 6'b000010;
    parameter C = 6'b000100;
    parameter D = 6'b001000;
    parameter E = 6'b010000;
    parameter F = 6'b100000;
    
    // Logic for Y1 (input of state flip-flop y[1])
    // Y1 is '1' when transitioning to state B
    assign Y1 = (y == A && w == 1'b1);
    
    // Logic for Y3 (input of state flip-flop y[3])
    // Y3 is '1' when transitioning to state D
    assign Y3 = (y == B && w == 1'b0) || 
                (y == C && w == 1'b0) || 
                (y == D && w == 1'b0) || 
                (y == E && w == 1'b0) || 
                (y == F && w == 1'b0);

endmodule
