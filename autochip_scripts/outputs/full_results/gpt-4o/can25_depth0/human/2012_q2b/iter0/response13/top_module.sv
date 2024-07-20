module top_module (
    input [5:0] y,    // current state
    input w,          // input signal
    output Y1,        // input to state flip-flop y[1]
    output Y3         // input to state flip-flop y[3]
);

    // State encoding
    parameter A = 6'b000001;
    parameter B = 6'b000010;
    parameter C = 6'b000100;
    parameter D = 6'b001000;
    parameter E = 6'b010000;
    parameter F = 6'b100000;

    // Y1 is the input to state flip-flop y[1], which represents state B
    assign Y1 = (y == A && w == 1) || (y == F && w == 1); 

    // Y3 is the input to state flip-flop y[3], which represents state D
    assign Y3 = (y == B && w == 0) || (y == C && w == 0) || (y == D && w == 0) || (y == E && w == 0) || (y == F && w == 0);

endmodule
