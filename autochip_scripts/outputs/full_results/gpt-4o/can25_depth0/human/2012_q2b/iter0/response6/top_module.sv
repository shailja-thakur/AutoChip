module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // State encoding using one-hot code
    parameter A = 6'b000001;
    parameter B = 6'b000010;
    parameter C = 6'b000100;
    parameter D = 6'b001000;
    parameter E = 6'b010000;
    parameter F = 6'b100000;

    // Y1: input to state flip-flop y[1]
    // It should be '1' if the next state is B, which occurs when:
    //  - Current state is A and input is 1
    //  - Current state is F and input is 1
    assign Y1 = (y == A && w == 1) || (y == F && w == 1);

    // Y3: input to state flip-flop y[3]
    // It should be '1' if the next state is D, which occurs when:
    //  - Current state is B and input is 0
    //  - Current state is C and input is 0
    //  - Current state is D and input is 0
    //  - Current state is E and input is 0
    //  - Current state is F and input is 0
    assign Y3 = (y == B && w == 0) || (y == C && w == 0) ||
                (y == D && w == 0) || (y == E && w == 0) ||
                (y == F && w == 0);

endmodule
