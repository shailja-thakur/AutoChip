module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // State encoding
    parameter A = 6'b000001;
    parameter B = 6'b000010;
    parameter C = 6'b000100;
    parameter D = 6'b001000;
    parameter E = 6'b010000;
    parameter F = 6'b100000;
    
    // Next state logic for Y2
    // Y2 corresponds to state B
    // From the state machine:
    // - State A (y[1]) goes to B if w == 0
    // - State E (y[5]) goes to D if w == 1 (does not affect Y2 logic)
    // - Other transitions do not affect state B (y[2])
    assign Y2 = y[1] & ~w;
    
    // Next state logic for Y4
    // Y4 corresponds to state D
    // From the state machine:
    // - State B (y[2]) goes to D if w == 1
    // - State C (y[3]) goes to D if w == 1
    // - State D (y[4]) goes to D if w == 0
    // - State E (y[5]) goes to D if w == 1
    // - State F (y[6]) goes to D if w == 1
    assign Y4 = (y[2] & w) | (y[3] & w) | (y[4] & ~w) | (y[5] & w) | (y[6] & w);

endmodule
