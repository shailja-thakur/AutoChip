module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

// Signal Y1 is the input of state flip-flop y[1]
// Based on the state diagram, the transitions to state B and D set y[1]
assign Y1 = (y[0] & w) | (y[3] & ~w);

// Signal Y3 is the input of state flip-flop y[3]
// Based on the state diagram, the transitions to state C, D, and F set y[3]
assign Y3 = (y[1] & w) | (y[3] & ~w) | (y[5] & w);

endmodule
