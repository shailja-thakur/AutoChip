module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);
    // State machine transitions
    // State encoding: y[5:0] = 000001(A), 000010(B), 000100(C), 001000(D), 010000(E), 100000(F)
    
    assign Y1 = (y[0] & w)   // From state A to B (y[0] --1--> y[1])
              | (y[3] & ~w); // From state D to A (y[3] --0--> y[0])
              
    assign Y3 = (y[1] & ~w)  // From state B to D (y[1] --0--> y[3])
              | (y[2] & ~w)  // From state C to D (y[2] --0--> y[3])
              | (y[4] & ~w)  // From state E to D (y[4] --0--> y[3])
              | (y[5] & ~w); // From state F to D (y[5] --0--> y[3])
endmodule
