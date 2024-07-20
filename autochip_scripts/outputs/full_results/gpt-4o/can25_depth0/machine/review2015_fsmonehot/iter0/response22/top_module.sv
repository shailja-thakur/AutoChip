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
    // Assignments for output signals based on current states
    assign done = state[9]; // Wait state
    assign counting = state[8]; // Count state
    assign shift_ena = state[5] | state[4] | state[3] | state[2]; // B3, B2, B1, B0 states
    assign B3_next = state[4]; // B2 state
    assign S_next = (state[0] & ~d) | (state[1] & ~d) | (state[3] & ~d) | (state[9] & ack); // S, S1, S110, Wait states
    assign S1_next = state[0] & d; // S state
    assign Count_next = state[5] | (state[8] & ~done_counting); // B3, Count states
    assign Wait_next = (state[8] & done_counting) | (state[9] & ~ack); // Count, Wait states
endmodule
