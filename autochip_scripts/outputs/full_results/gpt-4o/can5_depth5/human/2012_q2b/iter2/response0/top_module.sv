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

    // Y1 is the input to the flip-flop for state B (y[1])
    // Y3 is the input to the flip-flop for state D (y[3])
    
    // y[1] denotes state B, which will be true if:
    // - current state is A and input w is 1
    // - current state is B and input w is 1
    assign Y1 = (y == A && w == 1) || (y == B && w == 1);
    
    // y[3] denotes state D, which will be true if:
    // - current state is B and input w is 0
    // - current state is C and input w is 0
    // - current state is D and input w is 0
    // - current state is E and input w is 0
    // - current state is F and input w is 0
    assign Y3 = (y == B && w == 0) || (y == C && w == 0) || (y == D && w == 0) || (y == E && w == 0) || (y == F && w == 0);

endmodule
