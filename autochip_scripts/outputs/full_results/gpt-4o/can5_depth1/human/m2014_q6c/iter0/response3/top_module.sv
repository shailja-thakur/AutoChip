module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // State encoding:
    // A: 000001
    // B: 000010
    // C: 000100
    // D: 001000
    // E: 010000
    // F: 100000
    
    // Next-state logic for Y2 (state B):
    // Y2 = yA & ~w
    assign Y2 = y[1] & ~w;
    
    // Next-state logic for Y4 (state D):
    // Y4 = (yB & w) | (yC & w) | (yD & w) | (yE & w) | (yF & w)
    assign Y4 = (y[2] & w) | (y[3] & w) | (y[4] & w) | (y[5] & w) | (y[6] & w);
    
endmodule
