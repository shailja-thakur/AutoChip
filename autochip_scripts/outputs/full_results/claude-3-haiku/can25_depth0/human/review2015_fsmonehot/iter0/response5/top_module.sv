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

// Next-state logic equations
assign B3_next = (state[8]); // B3
assign S_next = (state[0] & ~d) | (state[2] & ~d) | (state[3] & ~d) | (state[9] & ack); // S
assign S1_next = (state[0] & d) | (state[1] & ~d); // S1
assign Count_next = (state[7] & ~done_counting); // Count
assign Wait_next = (state[7] & done_counting) | (state[9] & ~ack); // Wait

// Output logic equations
assign done = state[9]; // done
assign counting = state[7]; // counting
assign shift_ena = state[4] | state[5] | state[6] | state[7] | state[8]; // shift_ena

endmodule
