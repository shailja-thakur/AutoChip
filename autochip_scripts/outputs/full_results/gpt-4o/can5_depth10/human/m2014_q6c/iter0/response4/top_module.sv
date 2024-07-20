module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // State encoding
    // y[6:1] = 000001 -> State A
    // y[6:1] = 000010 -> State B
    // y[6:1] = 000100 -> State C
    // y[6:1] = 001000 -> State D
    // y[6:1] = 010000 -> State E
    // y[6:1] = 100000 -> State F
    
    assign Y2 = (y[1] & ~w) | (y[6] & w); // Transition to State B or stay in State F given input
    assign Y4 = (y[2] & ~w) | (y[4] & w) | (y[3] & w) | (y[5] & w); // Transition to State D given input
    
endmodule
