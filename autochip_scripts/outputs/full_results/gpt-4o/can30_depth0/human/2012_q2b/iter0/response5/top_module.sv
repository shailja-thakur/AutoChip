module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // Internal state encoding
    parameter A = 6'b000001;
    parameter B = 6'b000010;
    parameter C = 6'b000100;
    parameter D = 6'b001000;
    parameter E = 6'b010000;
    parameter F = 6'b100000;

    // Y1: This is the input of state flip-flop y[1]
    assign Y1 = (y == A && w == 1'b1) || (y == A && w == 1'b0) || 
                (y == B && w == 1'b1) || (y == C && w == 1'b0) || 
                (y == F && w == 1'b1);

    // Y3: This is the input of state flip-flop y[3]
    assign Y3 = (y == B && w == 1'b0) || (y == C && w == 1'b0) || 
                (y == D && w == 1'b0) || (y == F && w == 1'b0) || 
                (y == E && w == 1'b0);

endmodule
