module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

// Signal Y1 is the input to the state flip-flop y[1]
// It is 1 when the current state is B (000010) and the input is 1,
// or when the current state is D (001000) and the input is 0
assign Y1 = (y[1] && w) || (y[3] && !w);

// Signal Y3 is the input to the state flip-flop y[3]
// It is 1 when the current state is C (000100) and the input is 0,
// or when the current state is D (001000) and the input is 1,
// or when the current state is F (100000) and the input is 0
assign Y3 = (y[2] && !w) || (y[3] && w) || (y[5] && !w);

endmodule
