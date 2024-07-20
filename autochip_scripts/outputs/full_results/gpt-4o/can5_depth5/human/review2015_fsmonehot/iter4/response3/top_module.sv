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
    assign S_next = (state[0] & ~d) | (state[2] & ~d) | (state[3] & ~d) | (state[9] & ack);
    assign S1_next = (state[0] & d) | (state[1] & d);
    assign B3_next = state[6];
    assign Count_next = (state[7] | (state[8] & ~done_counting));
    assign Wait_next = (state[8] & done_counting) | (state[9] & ~ack);

    // Output logic
    assign shift_ena = state[4] | state[5] | state[6] | state[7];
    assign counting = state[8];
    assign done = state[9];

    // Fix the next-state logic for S1_next
    assign S1_next = (state[0] & d) | (state[1] & d & ~state[2]);

    // Fix the next-state logic for S_next
    assign S_next = (state[0] & ~d) | (state[2] & ~d) | (state[3] & ~d) | (state[9] & ack) | (state[6] & d & ~state[4]) | (state[5] & d & ~state[4]);

endmodule
