module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);
    // Define states for readability
    parameter A = 6'b000001;
    parameter B = 6'b000010;
    parameter C = 6'b000100;
    parameter D = 6'b001000;
    parameter E = 6'b010000;
    parameter F = 6'b100000;

    // Generate Y1 (next state B or D)
    assign Y1 = (y == A && w == 1) || 
                (y == B && w == 0);

    // Generate Y3 (next state D or F)
    assign Y3 = (y == B && w == 0) || 
                (y == C && w == 0) || 
                (y == D && w == 0) || 
                (y == E && w == 0) || 
                (y == F && w == 0);

endmodule
