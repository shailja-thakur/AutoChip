module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // State encoding
    // y[6:1]
    // A: 000001
    // B: 000010
    // C: 000100
    // D: 001000
    // E: 010000
    // F: 100000
    
    // Next-state logic for Y2 and Y4
    // Y2 (State B: 000010) = (A & ~w) | (F & ~w)
    assign Y2 = (y[1] & ~w) | (y[6] & ~w);
    
    // Y4 (State D: 001000) = (B & w) | (C & w) | (D & ~w) | (E & w) | (F & w)
    assign Y4 = (y[2] & w) | (y[3] & w) | (y[4] & ~w) | (y[5] & w) | (y[6] & w);

endmodule
