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
    assign S_next = (state[0] & ~d) | (state[2] & ~d) | (state[7] & ~d);
    assign S1_next = (state[0] & d) | (state[2] & d);
    assign Count_next = state[9] & ~done_counting;
    assign Wait_next = state[9] & done_counting;

    // Output logic
    assign done = state[9];
    assign counting = state[9];
    assign shift_ena = state[5] | state[6] | state[7] | state[8];

endmodule
