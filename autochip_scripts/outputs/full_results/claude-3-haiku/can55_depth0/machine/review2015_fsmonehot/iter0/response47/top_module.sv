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

    // Assign the output signals based on the current state
    assign B3_next = (state[3]); // B2 state
    assign S_next = (state[0] & ~d) | (state[1] & ~d) | (state[8] & ~d) | (state[9] & ack);
    assign S1_next = (state[0] & d);
    assign Count_next = (state[3]) | (state[7] & ~done_counting);
    assign Wait_next = (state[7] & done_counting) | (state[9] & ~ack);

    // Assign the done, counting, and shift_ena signals
    assign done = (state[9]); // Wait state
    assign counting = (state[7]); // Count state
    assign shift_ena = (state[3] | state[2] | state[1] | state[0]); // B3, B2, B1, B0 states

endmodule
