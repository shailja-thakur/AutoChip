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

    // Derive Y1, input of state flip-flop y[1]
    // Y1 is high if the next state should be B, which is the case when the current state is A and w is 1
    assign Y1 = (y == A) & w;

    // Derive Y3, input of state flip-flop y[3]
    // Y3 is high if the next state should be D, which is the case when:
    // - the current state is B and w is 0
    // - the current state is C and w is 0
    // - the current state is D and w is 0
    // - the current state is E and w is 0
    // - the current state is F and w is 0
    assign Y3 = ((y == B) & ~w) |
                ((y == C) & ~w) |
                ((y == D) & ~w) |
                ((y == E) & ~w) |
                ((y == F) & ~w);

endmodule
