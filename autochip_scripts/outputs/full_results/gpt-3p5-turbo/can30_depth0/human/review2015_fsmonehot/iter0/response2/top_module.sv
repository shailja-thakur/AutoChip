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

    // State Next-State Logic
    assign S_next = state[0] & ~d;
    assign S1_next = state[1] & d;
    assign Count_next = (state[2] & d) | (state[8] & ~done_counting);
    assign Wait_next = state[3] & done;

    // Output Logic
    assign done = state[3];
    assign counting = state[2] & ~done_counting;
    assign shift_ena = state[7] | state[8] | state[9];
    assign B3_next = state[7];

endmodule
