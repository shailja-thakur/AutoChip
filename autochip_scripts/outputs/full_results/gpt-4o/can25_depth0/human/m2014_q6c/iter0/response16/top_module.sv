module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // States encoded in one-hot representation
    // y[1] = A, y[2] = B, y[3] = C, y[4] = D, y[5] = E, y[6] = F
    
    // Next state logic for Y2 and Y4
    assign Y2 = (y[1] & ~w) | (y[3] & ~w);
    assign Y4 = (y[2] & w) | (y[3] & w) | (y[4] & w) | (y[5] & w) | (y[6] & w);
    
endmodule
