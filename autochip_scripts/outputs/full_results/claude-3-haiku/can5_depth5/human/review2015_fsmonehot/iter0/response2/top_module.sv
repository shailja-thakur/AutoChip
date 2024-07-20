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

// Next-state logic
assign B3_next = state[8] & d;
assign S_next = (state[0] & ~d) | (state[2] & ~d) | (state[6] & ~d);
assign S1_next = (state[0] & d) | (state[2] & d);
assign Count_next = state[7] & ~done_counting;
assign Wait_next = (state[7] & done_counting) | (state[9] & ~ack);

// Output logic
assign done = state[9];
assign counting = state[7];
assign shift_ena = state[4] | state[5] | state[6] | state[7];

endmodule
