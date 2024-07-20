module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);
    // State assignment
    // y[5:0] = 000001 (A)
    // y[5:0] = 000010 (B)
    // y[5:0] = 000100 (C)
    // y[5:0] = 001000 (D)
    // y[5:0] = 010000 (E)
    // y[5:0] = 100000 (F)
    
    // Y1 is the next state for state B (000010)
    // Y1 = (current state is A and input w is 1)
    assign Y1 = y[0] & w;

    // Y3 is the next state for state D (001000)
    // Y3 = (current state is B and input w is 0) 
    //      or (current state is C and input w is 0)
    //      or (current state is D and input w is 0)
    //      or (current state is E and input w is 0)
    //      or (current state is F and input w is 0)

    assign Y3 = (y[1] & ~w) | (y[2] & ~w) | (y[3] & ~w) | (y[4] & ~w) | (y[5] & ~w);

endmodule
