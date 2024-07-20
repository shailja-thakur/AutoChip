module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output B3_next,
    output S_next,
    output S1_next,
    output Count_next,
    output Wait_next,
    output done,
    output counting,
    output shift_ena
);

// State transition logic for B3
assign B3_next = state[9] && state[8] && state[7] && state[6] && state[5] && state[4] && state[3] && state[2] && state[1] && state[0];

// State transition logic for S
assign S_next = ~d;

// State transition logic for S1
assign S1_next = state[0] && d;

// State transition logic for Count
assign Count_next = state[9] && done_counting;

// State transition logic for Wait
assign Wait_next = state[9] && done_counting && ~ack;

// Output logic
assign done = state[9] && done_counting && ack;
assign counting = state[9] && done_counting;
assign shift_ena = state >= 10'b0111111111;

endmodule
