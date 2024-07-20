module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // One-hot encoded states
    wire state_A = y[1];
    wire state_B = y[2];
    wire state_C = y[3];
    wire state_D = y[4];
    wire state_E = y[5];
    wire state_F = y[6];
    
    // Next state logic for Y2 (state B)
    assign Y2 = (state_A & ~w) |
                (state_F & ~w);
    
    // Next state logic for Y4 (state D)
    assign Y4 = (state_B & w) |
                (state_C & w) |
                (state_D & w) |
                (state_E & w) |
                (state_F & w);
    
endmodule
