module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

// Signal Y1 (input of state flip-flop y[1])
// From the state diagram, we can see that the input of flip-flop y[1] is:
// 1 for state B, C, and F
// 0 for state A, D, and E
assign Y1 = y[1] | y[2] | y[5];

// Signal Y3 (input of state flip-flop y[3])
// From the state diagram, we can see that the input of flip-flop y[3] is:
// 1 for state C and E
// 0 for state A, B, D, and F
assign Y3 = y[2] | y[4];

endmodule
