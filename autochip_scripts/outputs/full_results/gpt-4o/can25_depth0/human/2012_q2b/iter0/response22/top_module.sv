module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // State encoding based on the one-hot code
    // y[5:0] = 000001(A), 000010(B), 000100(C), 001000(D), 010000(E), 100000(F)
    
    // Y1 is the next state B or D
    assign Y1 = (y[0] & w) | (y[3] & ~w);
    
    // Y3 is the next state D
    assign Y3 = (y[1] & ~w) | (y[2] & ~w) | (y[3] & ~w) | (y[4] & ~w) | (y[5] & ~w);

endmodule
